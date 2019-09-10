//
//  UserPicEditTableViewCell.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

//MARK:- UserDetailTableViewCell
class UserPicEditTableViewCell: UITableViewCell {

    //MARK: IBOutlet Member declarations
    @IBOutlet weak var cameraActionButton: RUIBorderedClickableImageView!
    @IBOutlet weak var profileImgView: RUIBorderedImageView!
    
    var cameraActionCallBack: (() -> ())? = nil
    
    //MARK: cellLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cameraActionButton.callBack = { [unowned self] in
            if let block = self.cameraActionCallBack {
                block()
            }
        }
    }
    
}
