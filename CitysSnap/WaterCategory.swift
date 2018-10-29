//
//  WaterCategory.swift
//  CitysSnap
//
//  Created by Bamdad Sahraei on 2018-09-22.
//  Copyright © 2018 Bamdad Sahraei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class WaterCategory: UIViewController {
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        let blurrEffect=UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurrView = UIVisualEffectView(effect: blurrEffect)
        
        blurrView.frame.size = CGSize(width: 800, height: 800)
        blurrView.center = view.center
        view.addSubview(blurrView)
        view.sendSubview(toBack: blurrView)
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func waterButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var category="water"
    @IBAction func submitButtonPressed(_ sender: Any) {
        let newReport = self.ref!.childByAutoId()
        newReport.setValue([
            "category":category,
            "image":linkFile,
            "lat":lat,
            "lng":lng
            ])
        let alert = UIAlertController(title: "Report Recieved!", message: "We will look into the reported issue in the next 48 hours", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 3 seconds)
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            blurrView.isHidden=true
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
