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
        button.backgroundColor = UIColor(red: 234/255.0, green: 153/255.0, blue: 117/255.0, alpha: 1.0)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor =  UIColor(named: "dark-brown")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "dark-brown")?.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        
        let rect = createRoundedRectLayer(frame: CGRect(x: 0, y: 0, width: 67, height: 48), color: UIColor(red: 251/255.0, green: 195/255.0, blue: 153/255.0, alpha: 1.0))
        
        button.layer.insertSublayer(rect, at: 0)
        button.bringSubviewToFront(button.imageView!)
        return button
    }
    
    static func make3DButtonWithText(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 234/255.0, green: 153/255.0, blue: 117/255.0, alpha: 1.0)
        
        button.setTitle(text.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: "dark-brown"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = UIColor(named: "dark-brown")?.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        
        let rect1 = createRoundedRectLayer(frame: CGRect(x: 0, y: 0, width: 195, height: 45), color: UIColor(red: 241/255.0, green: 170/255.0, blue: 131/255.0, alpha: 1.0))
        let rect2 = createRoundedRectLayer(frame: CGRect(x: 0, y: 0, width: 95, height: 45), color: UIColor(red: 251/255.0, green: 195/255.0, blue: 153/255.0, alpha: 1.0))
        
        button.layer.insertSublayer(rect1, at: 0)
        button.layer.insertSublayer(rect2, at: 1)
        return button
    }
    
    
    static func makeButtonWithText(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(red: 241/255.0, green: 170/255.0, blue: 131/255.0, alpha: 1.0)
        
        button.setTitle(text.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func makeActionButton(icon: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.setImage(UIImage(named: icon), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 35/255.0, green: 37/255.0, blue: 134/255.0, alpha: 1.0).withAlphaComponent(0.6)
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
