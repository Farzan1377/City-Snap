//
//  ViewController.swift
//  VertiShotBeta4
//
//  Created by Bamdad Sahraei on 2018-02-24.
//  Copyright © 2018 Bamdad Sahraei. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
var linkFile = ""
var lat=0.10000
var lng=0.10000
var image: UIImage?
class ImageViewController : UIViewController, BWWalkthroughViewControllerDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    var locationManager: CLLocationManager!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        imageView.image = image
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        print(locationManager)
        
        
        
        let data = UIImageJPEGRepresentation(image!, 0.8)
        //print(data)
        //Encoding to Base64 to send to imgur
        let base64Image = data!.base64EncodedString()
        //print(base64Image)
        
        let parameters: Parameters = [
            "type": "base64",
            "image": base64Image
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 925a8b3061eafad"
        ]
        
        Alamofire.request("https://api.imgur.com/3/image", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            //print(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("hhhh")
                }
            }
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let data = JSON["data"] as! NSDictionary
                //print(data)
                let link = data["link"]!
                print(link)
                linkFile=link as! String
                
            }
        }
        print("cvbnm")
        // Do any additional setup after loading the view, typically from a nib.
    }

        
        
    
    
    
    // 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        //print("Current location: \(currentLocation)")
        lat = currentLocation.coordinate.latitude
        lng = currentLocation.coordinate.longitude
        
        
    }
    
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
    
    @IBAction func closeButtonDidTap () {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func save(sender: UIButton) {
        guard let imageToSave = image else {
            return
        }
        // 1
        let status  = CLLocationManager.authorizationStatus()
        
        // 2
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // 3
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        // 4
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        print("walkedThroughButtonPressed")
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let walkthrough = stb.instantiateViewController(withIdentifier: "walk0") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "walk1") as UIViewController
        let page_two = stb.instantiateViewController(withIdentifier: "walk2") as UIViewController
        
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.add(viewController: page_one)
        walkthrough.add(viewController: page_two)
        
        self.present(walkthrough, animated: true, completion: nil)
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        
       // dismiss(animated: false, completion: nil)
        
        
    }
    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}



















