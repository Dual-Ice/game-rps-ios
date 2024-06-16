//
//  UIImageView+Animation.swift
//  rps-game-ios
//
//  Created by nikita on 15.06.24.
//

import UIKit

extension UIImageView {
    func punch(up: Bool) {
        let punch = CASpringAnimation(keyPath: "transform.translation.y")
        
        punch.fromValue = 0
        punch.toValue = up ? -150 : 150
        punch.autoreverses = true
        punch.duration = 0.5
        punch.initialVelocity = 10
        punch.damping = 100
        
        layer.add(punch, forKey: nil)
    }
    
    func splashBlood() {
        let splash = CASpringAnimation(keyPath: "transform.scale")
        
        splash.fromValue = 0
        splash.toValue = 1
        splash.autoreverses = true
        splash.duration = 0.5
        
        layer.add(splash, forKey: nil)
    }
}
