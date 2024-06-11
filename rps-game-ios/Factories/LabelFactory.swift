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
}
