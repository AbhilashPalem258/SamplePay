//
//  Colors.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

extension UIColor {
    static var TextBlack: UIColor {
        return UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
    }
    static var lightGreyHeading: UIColor {
        return UIColor(red: 190.0/255.0, green: 190.0/255.0, blue: 190.0/255.0, alpha: 1)
    }
    static var lineSeparatorColor: UIColor {
        return UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
    }
    static var WhiteBGColor: UIColor {
        return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1)
    }
    static var CDGreen: UIColor {
        return  UIColor(red: 221.0/255.0, green: 245.0/255.0, blue: 240.0/255.0, alpha: 1)
    }
    
    
    static func getColorFromString(colorInString: String?) -> UIColor{
        var actualColor: UIColor! = UIColor.clear
        
        let colorInStr = colorInString ?? ColorConstants.clear
        
        if(colorInStr.caseInsensitiveCompare(ColorConstants.textBlack) == ComparisonResult.orderedSame){
            actualColor = UIColor.TextBlack
        }
        else if (colorInStr.caseInsensitiveCompare(ColorConstants.clear) == ComparisonResult.orderedSame){
            actualColor = UIColor.clear
        }
        else if(colorInStr.caseInsensitiveCompare(ColorConstants.lightGreyHeading) == ComparisonResult.orderedSame){
            actualColor = UIColor.lightGreyHeading
        }
        
        return actualColor
    }
}
