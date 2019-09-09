//
//  RUITextField.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

class RUITextField: UITextField {
    
    @IBInspectable var FontSizeType: String?
    @IBInspectable var FontStyleType: String?
    @IBInspectable var LabelTextColor: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textColor = UIColor.getColorFromString(colorInString: LabelTextColor)
        self.font = UIFont.getFontAndFontSizeInString(fontSizeType: FontSizeType, fontStyle: FontStyleType)
    }
}

