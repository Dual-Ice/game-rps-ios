//
//  FontExtension .swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import UIKit

enum RubikType: String {
    case regular = "Rubik-Light_Regular"
    case light = "Rubik-Light"
    case medium = "Rubik-Light_Medium"
    case bold = "Rubik-Light_Bold"
}

extension UIFont {
    static func customRubikFont(fontType: RubikType = .regular, size: CGFloat = 16) -> UIFont {
        return UIFont(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}





//["Rubik-Light_Regular", "Rubik-Light", "Rubik-Light_Medium", "Rubik-Light_SemiBold", "Rubik-Light_Bold", "Rubik-Light_ExtraBold", "Rubik-Light_Black"]

