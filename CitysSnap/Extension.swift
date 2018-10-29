//
//  Extension.swift
//  NaborDoo
//
//  Created by Bamdad Sahraei on 2018-07-11.
//  Copyright © 2018 Bamdad Sahraei. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
