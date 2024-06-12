//
//  FontExtension .swift
//  rps-game-ios
//
//  Created by Alexander on 11.06.24.
//

import UIKit

enum RubikFont {
    enum Regular {
        static func size(of size: CGFloat) -> UIFont {
            return UIFont(name: "Rubik-Light_Regular", size: size) ?? UIFont()
        }
    }
    
    enum Light {
        static func size(of size: CGFloat) -> UIFont {
            return UIFont(name: "Rubik-Light", size: size) ?? UIFont()
        }
    }
    
    enum Medium {
        static func size(of size: CGFloat) -> UIFont {
            return UIFont(name: "Rubik-Light_Medium", size: size) ?? UIFont()
        }
    }
    
    enum Bold {
        static func size(of size: CGFloat) -> UIFont {
            return UIFont(name: "Rubik-Light_Bold", size: size) ?? UIFont()
        }
    }
}

//["Rubik-Light_Regular", "Rubik-Light", "Rubik-Light_Medium", "Rubik-Light_SemiBold", "Rubik-Light_Bold", "Rubik-Light_ExtraBold", "Rubik-Light_Black"]

