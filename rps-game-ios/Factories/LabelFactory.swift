//
//  LabelFactory.swift
//  rps-game-ios
//
//  Created by  Maksim Stogniy on 10.06.2024.
//

import UIKit

final class LabelFactory {
    static func makeLargeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(red: 255/255.0, green: 178/255.0, blue: 76/255.0, alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 56)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text.uppercased()
        return label
    }
    
    static func makeSmallLabel(text: String) -> UILabel  {
        let label = UILabel()
        label.textColor = UIColor(red: 255/255.0, green: 178/255.0, blue: 76/255.0, alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    static func makeScreenLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(red: 60/255.0, green: 58/255.0, blue: 58/255.0, alpha: 1.0)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    static func makeStartScreenLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9395877719, green: 0.6671555638, blue: 0.5318560004, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: text)
        let customFont = UIFont(name: "Rubik-Bold", size: 56) ??  UIFont.boldSystemFont(ofSize: 56)
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        // Установка тени
        let shadow = NSShadow()
        shadow.shadowColor = #colorLiteral(red: 0.9192885756, green: 0.6009836197, blue: 0.4597279429, alpha: 1)
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 1
        attributedText.addAttribute(.shadow, value: shadow, range: NSRange(location: 0, length: attributedText.length))
        // Применение атрибутированного текста к UILabel
        label.attributedText = attributedText
        return label
    }
}
