//
//  ButtonFactory.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 10.06.2024.
//

import UIKit

final class ButtonFactory {
    static func make3DButtonWithIcon(imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.CustomColors.orangeBackgroundButton
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor =  UIColor.CustomColors.darkBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor.CustomColors.orangeShadowButton.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        
        let rect = createRoundedRectLayer(frame: CGRect(x: 0, y: 0, width: 67, height: 48), color: UIColor.CustomColors.orangePrimaryButton)
        
        button.layer.insertSublayer(rect, at: 0)
        button.bringSubviewToFront(button.imageView!)
        return button
    }
    
    static func make3DButtonWithText(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.CustomColors.orangeBackgroundButton
        
        button.setTitle(text.uppercased(), for: .normal)
        button.titleLabel?.font = RubikFont.Bold.size(of: 16)
        button.setTitleColor(UIColor.CustomColors.darkBrown, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor.CustomColors.orangeShadowButton.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        
        let rect1 = createRoundedRectLayer(frame: CGRect(x: 0, y: 0, width: 195, height: 45), color: UIColor.CustomColors.orangeBackgroundButton)
        let rect2 = createRoundedRectLayer(frame: CGRect(x: 0, y: 0, width: 95, height: 45), color: UIColor.CustomColors.orangePrimaryButton)
        
        button.layer.insertSublayer(rect1, at: 0)
        button.layer.insertSublayer(rect2, at: 1)
        return button
    }
    
    
    static func makeButtonWithText(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.CustomColors.orangeBackgroundButton
        
        button.setTitle(text.uppercased(), for: .normal)
        button.titleLabel?.font = RubikFont.Bold.size(of: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeActionButton(icon: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tag
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.setImage(UIImage(named: icon), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.CustomColors.darkBlueTimeline.withAlphaComponent(0.6)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

extension ButtonFactory {
    static private func createRoundedRectLayer(frame: CGRect, color: UIColor) -> CALayer {
        let layer = CALayer()
        layer.frame = frame
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 20
        return layer
    }

}
