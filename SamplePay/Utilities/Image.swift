//
//  Image.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

extension UIImage {
    static let placeholderImage = UIImage.init(named: "placeholder_photo", in: Bundle(for: type(of: self) as! AnyClass), compatibleWith: nil)
}
