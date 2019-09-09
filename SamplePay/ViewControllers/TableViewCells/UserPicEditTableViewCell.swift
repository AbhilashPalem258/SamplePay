//
//  UserPicEditTableViewCell.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

class UserPicEditTableViewCell: UITableViewCell {

    @IBOutlet weak var cameraActionButton: RUIBorderedClickableImageView!
    @IBOutlet weak var profileImgView: RUIBorderedImageView!
    
    var cameraActionCallBack: (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cameraActionButton.callBack = { [unowned self] in
            if let block = self.cameraActionCallBack {
                block()
            }
        }
    }
    
}
