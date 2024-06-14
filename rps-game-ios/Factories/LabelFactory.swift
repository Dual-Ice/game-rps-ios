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
        label.textColor = UIColor.CustomColors.pastelYellowText
        label.numberOfLines = 1
        label.font = RubikFont.Bold.size(of: 56)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text.uppercased()
        return label
    }
    
    static func makeSmallLabel(text: String) -> UILabel  {
        let label = UILabel()
        label.textColor = UIColor.CustomColors.pastelYellowText
        label.numberOfLines = 1
        label.font = RubikFont.Bold.size(of: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    static func makeScreenLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.CustomColors.customBlack
        label.numberOfLines = 1
        label.font = RubikFont.Regular.size(of: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    static func makeStartScreenLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(red: 240/255.0, green: 170/255.0, blue: 136/255.0, alpha: 1.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: text)
        let customFont = UIFont(name: "Rubik-Bold", size: 56) ??  UIFont.boldSystemFont(ofSize: 56)
        attributedText.addAttribute(.font, value: customFont, range: NSRange(location: 0, length: attributedText.length))
        // Установка тени
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 234/255.0, green: 153/255.0, blue: 117/255.0, alpha: 1.0)
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 1
        attributedText.addAttribute(.shadow, value: shadow, range: NSRange(location: 0, length: attributedText.length))
        // Применение атрибутированного текста к UILabel
        label.attributedText = attributedText
        return label
    }
}
