//
//  LitterCategory.swift
//  CitysSnap
//
//  Created by Bamdad Sahraei on 2018-09-22.
//  Copyright © 2018 Bamdad Sahraei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LitterCategory: UIViewController {
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        submitOutlet.isHidden=true
        overFlowSelected.isHidden=true
        sidewalkLitterSelected.isHidden=true
        
        let blurrEffect=UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurrView = UIVisualEffectView(effect: blurrEffect)
        
        blurrView.frame.size = CGSize(width: 800, height: 800)
        blurrView.center = view.center
        view.addSubview(blurrView)
        view.sendSubview(toBack: blurrView)
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    var category = "None"
    @IBAction func overFlow(_ sender: Any) {
        overFlowSelected.isHidden=false
        sidewalkLitterSelected.isHidden=true
        
        self.view.bringSubview(toFront: overFlowSelected)
        
        
        category = "overflow"
        submitOutlet.isHidden=false
    }
    @IBAction func sideWalkLitter(_ sender: Any) {
        sidewalkLitterSelected.isHidden=false
        overFlowSelected.isHidden=true
        
        self.view.bringSubview(toFront: sidewalkLitterSelected)
        
        
        category = "sidewalk litter"
        submitOutlet.isHidden=false
    }
    
    @IBAction func submit(_ sender: Any) {
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
    @IBOutlet weak var overFlowSelected: UIView!
    
    @IBOutlet weak var submitOutlet: UIButton!
    
    @IBOutlet weak var sidewalkLitterSelected: UIView!
    @IBAction func closePressed(_ sender: Any) {
        showAllCat=true
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closePressed2(_ sender: Any) {
        showAllCat=true
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
