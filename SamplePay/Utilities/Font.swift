//
//  Font.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

enum FontStyle: String {
    case Thin
    case Regular
    case SemiBold
    case Bold
    
    static func getFontStyleFromString(fontStyleInStr: String!) -> FontStyle {
        var fontStyle: FontStyle!
        if (fontStyleInStr.caseInsensitiveCompare(FontStyle.Regular.rawValue) == ComparisonResult.orderedSame) {
            fontStyle = FontStyle.Regular
        }
        else if (fontStyleInStr.caseInsensitiveCompare(FontStyle.Thin.rawValue) == ComparisonResult.orderedSame) {
            fontStyle = FontStyle.Thin
        }
        else if (fontStyleInStr.caseInsensitiveCompare(FontStyle.SemiBold.rawValue) == ComparisonResult.orderedSame) {
            fontStyle = FontStyle.SemiBold
        }
        else if (fontStyleInStr.caseInsensitiveCompare(FontStyle.Bold.rawValue) == ComparisonResult.orderedSame) {
            fontStyle = FontStyle.Bold
        }
        else {
            fontStyle = FontStyle.Regular
        }
        return fontStyle
    }
}

enum FontSize: String {
    case VeryVerySmall
    case VerySmall
    case Small
    case Medium
    case MedHigh
    case High
    case VeryHigh
    case VeryHigh32
    case VeryVeryHigh
    
    var value: CGFloat {
        switch self {
        case .VeryVerySmall:
            return 10
        case .VerySmall:
            return 12
        case .Small:
            return 13
        case .Medium:
            return 14
        case .MedHigh:
            return 16
        case .High:
            return 20
        case .VeryHigh:
            return 24
        case .VeryHigh32:
            return 32
        case .VeryVeryHigh:
            return 40
        }
    }
    
    static func getFontSizeFromString(fontSizeInStr: String!) -> FontSize {
        var fontSize: FontSize!
        if (fontSizeInStr.caseInsensitiveCompare(FontSize.VeryVerySmall.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.VeryVerySmall
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.VerySmall.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.VerySmall
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.Small.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.Small
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.Medium.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.Medium
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.MedHigh.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.MedHigh
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.High.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.High
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.VeryHigh.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.VeryHigh
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.VeryHigh32.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.VeryHigh32
        }
        else if (fontSizeInStr.caseInsensitiveCompare(FontSize.VeryVeryHigh.rawValue) == ComparisonResult.orderedSame) {
            fontSize = FontSize.VeryVeryHigh
        }
        else {
            fontSize = FontSize.Medium
        }
        return fontSize
    }
}
extension UIFont {
    static func customFontNameRegular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func customFontNameSemiBold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func customFontNameBold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func getFontAndFontSizeInString(fontSizeType: String?, fontStyle fontStyleType: String?) -> UIFont {
        var font: UIFont!
        let fontSizeInStr = fontSizeType ?? FontSize.Medium.rawValue
        let fontStyleInStr = fontStyleType ?? FontStyle.Regular.rawValue
        
        let fontSize: FontSize = FontSize.getFontSizeFromString(fontSizeInStr: fontSizeInStr)
        let fontStyle: FontStyle = FontStyle.getFontStyleFromString(fontStyleInStr: fontStyleInStr)
        
        if fontStyle == FontStyle.Regular{
            font = UIFont.customFontNameRegular(size: fontSize.value)
        }else if fontStyle == FontStyle.SemiBold{
            font = UIFont.customFontNameSemiBold(size: fontSize.value)
        }else if fontStyle == FontStyle.Bold{
            font = UIFont.customFontNameBold(size: fontSize.value)
        }
        return font
    }
}
