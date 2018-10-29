//
//  SettingsViewController.swift
//  VertiShotBeta4
//
//  Created by Bamdad Sahraei on 2018-02-25.
//  Copyright © 2018 Bamdad Sahraei. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    
    var hapticRecieved = hapticFeedB
    var ShowDegreeRecieved = ShowDegree
    var RecievedAutoShot=false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if RecievedAutoShot==false{
            SwitchOfAutoShot.setOn(false, animated: true)
        }
        else if RecievedAutoShot==true{
            SwitchOfAutoShot.setOn(true, animated: true)
        }
        Slider.value = Float(hapticRecieved)
        DegreeShowingSwitch.setOn(ShowDegreeRecieved, animated: true)
        AccuracyText.text=String(Int(AccuracyRangeOfMotion))
    }
    @IBAction func CloseButtonDidTap(_ sender: Any) {
        autoShot=RecievedAutoShot
        hapticFeedB=hapticRecieved
        ShowDegree = ShowDegreeRecieved
        AccuracyRangeOfMotion=Double(AccuracyText.text!)!
        self.dismiss(animated: false, completion: nil)
    }
    
////////////////////
    @IBOutlet weak var SwitchOfAutoShot: UISwitch!
    @IBAction func AutoShot(_ sender: Any) {
        if RecievedAutoShot==false{
            SwitchOfAutoShot.setOn(true, animated: true)
            RecievedAutoShot=true
        }
        else if RecievedAutoShot==true{
            SwitchOfAutoShot.setOn(false, animated: true)
            RecievedAutoShot=false
        }
    }
////////////////////
    @IBOutlet var Slider: UISlider!
    @IBAction func VibrationSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
        hapticRecieved=Int(sender.value)
        
    }

////////////////////
    
    @IBOutlet var DegreeShowingSwitch: UISwitch!
    @IBAction func DegreeShowing(_ sender: Any) {
        if ShowDegreeRecieved==false{
            DegreeShowingSwitch.setOn(true, animated: true)
            ShowDegreeRecieved=true
        }
        else if ShowDegreeRecieved==true{
            DegreeShowingSwitch.setOn(false, animated: true)
            ShowDegreeRecieved=false
    }
    }
////////////////////
    
    @IBOutlet var AccuracyText: UITextField!
    
////////////////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        AccuracyText.resignFirstResponder()
    }
    
  
    
    
//    @IBAction func AccuracyChange(_ sender: UITextField) {
//        AccuracyRangeOfMotion=Double(UITextField)
//    }
    ////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
