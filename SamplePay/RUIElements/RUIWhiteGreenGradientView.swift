//
//  RUIWhiteGreenGradientView.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

class RUIWhiteGreenGradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        createGradientLayer()
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.CDGreen.cgColor]
        gradientLayer.locations = [0, 0.3]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

