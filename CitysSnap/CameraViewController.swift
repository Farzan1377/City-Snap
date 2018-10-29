//
//  ViewController.swift
//  VertiShotBeta4
//
//  Created by Bamdad Sahraei on 2018-02-24.
//  Copyright © 2018 Bamdad Sahraei. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

var autoShot=false
var hapticFeedB = 3
var ShowDegree = true
var AccuracyRangeOfMotion = 3.0
var nearYou = true



let blurrEffect=UIBlurEffect(style: UIBlurEffectStyle.light)
let blurrView = UIVisualEffectView(effect: blurrEffect)




class CameraViewController : UIViewController
{
    var impact = UIImpactFeedbackGenerator(style: .heavy)
    var motionManager = CMMotionManager()
    
    let greenColor = UIColor.green
    let blackColor = UIColor.black
    let blueColor = UIColor.blue
    
    var ShowDegreeAlpha = 1.0
    var inRage = false
    var takePhoto = false
    
    var timer: Timer!
    
    
    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession()
    
    // which camera input do we want to use
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    // output device
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    
    // camera preview layer
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // double tap to switch from back to front facing camera
    var toggleCameraGestureRecognizer = UITapGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(CameraViewController.update), userInfo: nil, repeats: true)
        
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let devices = AVCaptureDevice.devices(for: AVMediaType.video) as! [AVCaptureDevice]
        for device in devices {
            if device.position == .back {
                backFacingCamera = device
            } else if device.position == .front {
                frontFacingCamera = device
            }
        }
        
        
        // default device
        currentDevice = backFacingCamera
        
        // configure the session with the output for capturing our still image
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(stillImageOutput!)
            
            // set up the camera preview layer
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(cameraPreviewLayer!)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            cameraPreviewLayer?.frame = view.layer.frame
            
            view.bringSubview(toFront: cameraButton)
//            view.bringSubview(toFront: LableGrayBackground)
//            view.bringSubview(toFront: currentDegree)
//            view.bringSubview(toFront: BarLeft)
//            view.bringSubview(toFront: BarRight)
//            view.bringSubview(toFront: BarUp)
//            view.bringSubview(toFront: LableGrayBackgroundSettings)
            
            blurrView.frame.size = CGSize(width: 800, height: 800)
            blurrView.center = view.center
            view.addSubview(blurrView)
            
            view.bringSubview(toFront: closeNearYouOutlet)
            view.bringSubview(toFront: nearYouMessage)
            view.bringSubview(toFront: nearYouLabel)
            
            captureSession.startRunning()
            
            // toggle the camera
            toggleCameraGestureRecognizer.numberOfTapsRequired = 2
            toggleCameraGestureRecognizer.addTarget(self, action: #selector(toggleCamera))
            view.addGestureRecognizer(toggleCameraGestureRecognizer)
            
        } catch let error {
            print(error)
        }
    }
  
    @IBOutlet var nearYouMessage: UIView!
    
    @IBOutlet var thumbsUpOutlet: UIButton!
    
    @IBOutlet var thumbsDownOutlet: UIButton!
    
    @IBOutlet var nearYouLabel: UILabel!
    
    @IBAction func dislikePressed(_ sender: Any) {
        nearYou=false
    }
    @IBAction func likePressed(_ sender: Any) {
        nearYou=false
    }
    
    @IBAction func closeNearYou(_ sender: Any) {
        nearYou=false
    }
    @IBOutlet var closeNearYouOutlet: UIButton!
    
    //    @IBAction func SettingsButton(_ sender: Any) {
    
//    }
    
    
    @objc func update() {
        
        if(nearYou==false)
        {
            blurrView.isHidden=true
            closeNearYouOutlet.isHidden = true
            nearYouMessage.isHidden=true
            nearYouLabel.isHidden=true
        }
    }
    @objc private func toggleCamera() {
        // start the configuration change
        captureSession.beginConfiguration()
        
        let newDevice = (currentDevice?.position == . back) ? frontFacingCamera : backFacingCamera
        
        for input in captureSession.inputs {
            captureSession.removeInput(input as! AVCaptureDeviceInput)
        }
        
        let cameraInput: AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice!)
        } catch let error {
            print(error)
            return
        }
        
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        
        currentDevice = newDevice
        captureSession.commitConfiguration()
    }
    
   
    @IBAction func shutterButtonDidTap()
    {
        let videoConnection = stillImageOutput?.connection(with: AVMediaType.video)
        impact=UIImpactFeedbackGenerator(style: .heavy)
        // capture a still image asynchronously
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection!, completionHandler: { (imageDataBuffer, error) in
            
            if let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataBuffer!, previewPhotoSampleBuffer: imageDataBuffer!) {
                self.stillImage = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let imageViewController = segue.destination as! ImageViewController
            imageViewController.image = self.stillImage
        }
        else if segue.identifier == "showSettings" {
            let StVC: SettingsViewController = segue.destination as! SettingsViewController
            StVC.RecievedAutoShot=autoShot
        }
    }
}




