//
//  UIFont+Extension.swift
//  LeboncoinTest
//
//  Created by CHEN on 10/07/2022.
//

import Foundation
import UIKit

extension UIFont {
    // TODO: Get all the fonts for every target and make them global
    
    //Setup "AvenirNext" as main app font
    static let appFont = "AvenirNext-Regular"
    static let appFontBold = "AvenirNext-Bold"
    static let appFontItalic = "AvenirNext-Italic"
    static let appFontDemiBold = "AvenirNext-DemiBold"
    
    static func setAppFont(size: CGFloat) -> UIFont {
        return UIFont(name: UIFont.appFont, size: size)!
    }
    
    static func setDemiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: UIFont.appFontDemiBold, size: size)!
    }
    
    static func setBoldAppFont(size: CGFloat) -> UIFont {
        return UIFont(name: UIFont.appFontBold, size: size)!
    }
}
