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
}
