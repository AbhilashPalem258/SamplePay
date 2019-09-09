//
//  RUIImageView.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

import UIKit

class RUIImageView: UIImageView {
    
}

class RUIBorderedImageView: RUIImageView {
    @IBInspectable var borderColor: String?
    @IBInspectable var borderWidth: String?
    @IBInspectable var cornerRadius: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.getColorFromString(colorInString: borderColor).cgColor
        layer.borderWidth = borderWidth?.toCGFloat() ?? 0
        if let radius = cornerRadius {
            if !radius.isEmpty {
                layer.cornerRadius = radius.toCGFloat() ?? 0.0
            }
        }
    }
}

class RUIBorderedClickableImageView: RUIBorderedImageView {
    var callBack: (() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfiguration()
    }
    
    func initialConfiguration() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    @objc func handleTap() {
        if let onClickAction = callBack {
            onClickAction()
        }
    }
}

