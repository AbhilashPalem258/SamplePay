//
//  UserDetailTableViewCell.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

//MARK:- UserDetailTableViewCell
final class UserDetailTableViewCell: UITableViewCell {
    //MARK: IBOutlet Member declarations
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var valueTF: UITextField!
    
    //MARK: cellLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.WhiteBGColor
    }
    
}
