//
//  Colors.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 09/11/21.
//

import Foundation
import UIKit

///
///USAGE
///

/// Create an enum to handle each and every colour required in our application.
enum Color {
    
    /// Button border color
    static let reloadButtonBorderGradientColor = Color.custom(hexString: "#FFFFFF", alpha: 0.13).value
    
    /// View border color
    static let userCellViewBorderGradientColor1 = Color.custom(hexString: "#FFFFFF", alpha: 0.13).value
    static let userCellViewBorderGradientColor2 = Color.custom(hexString: "#FFFFFF", alpha: 0.0).value
    
    static let topSegmentBorderColor = Color.custom(hexString: "#00FFD0", alpha: 1.0).value
    
    ///
    /// CASE STARTS FROM HERE
    
    ///
    ///Colours on Navigation Bar, Button Titles, Progress Indicator etc.
    case theme
    
    ///Hair line separators in between views.
    case border
    
    /// Shadow colours for card like design.
    case shadow
    
    /// Dark background colour to group UI components with light colour.
    case darkBackground
    
    /// Light background colour to group UI components with dark colour.
    case lightBackground
    
    /// Used for grouping UI elements with some other colour scheme.
    case intermidiateBackground
    
    /// Dark Text Colour
    case darkText
    
    /// Light Text Colour
    case lightText
    
    /// Intermediate Text Colour
    case intermidiateText
    
    /// Colour to show success, something right for user.
    case affirmation
    
    /// Colour to show error, some danger zones for user.
    case negation
    
    /// custom(hexString: String, alpha: Double) to get UIColor values other than the previous ones.
    case custom(hexString: String, alpha: Double)
    
    /// withAlpha(_ alpha: Double) to get UIColor values with opacity.
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

/// Put the values (hex string or RGB literal) to the following extension of Color enum
extension Color {
    
    /// Color from hex
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .border:
            instanceColor = UIColor(hexString: "#3c3c3c")
        case .theme:
            instanceColor = UIColor(hexString: "#212121")
        case .shadow:
            instanceColor = UIColor(hexString: "#cccccc")
        case .darkBackground:
            instanceColor = UIColor(hexString: "#1b1b1b")
        case .lightBackground:
            instanceColor = UIColor(hexString: "#D0D8DF")
        case .intermidiateBackground:
            instanceColor = UIColor(hexString: "#cccc99")
        case .darkText:
            instanceColor = UIColor(hexString: "#333333")
        case .intermidiateText:
            instanceColor = UIColor(hexString: "#999999")
        case .lightText:
            instanceColor = UIColor(hexString: "#d8d8d8")
        case .affirmation:
            instanceColor = UIColor(hexString: "#00ff66")
        case .negation:
            instanceColor = UIColor(hexString: "#ff3300")
        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return instanceColor
    }
}
