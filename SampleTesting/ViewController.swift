//
//  ViewController.swift
//  SampleTesting
//
//  Created by sapphre on 10/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit
import SamplePay

//MARK:- ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func btnAction(_ sender: Any) {
        let options = SamplePayConfigurationOptions.init(rootViewController: self, delegate: self)
        SamplePay.shared.setConfigurationOptions(options: options)
        
        do {
            try SamplePay.shared.enterUserDetails()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
//MARK:- ViewController: SamplePayDelegate Method Implementation
extension ViewController: SamplePayDelegate {
    func didFinishedWithEnteringUserDetails(user: User!) {
        print(user!)
        self.profileImageView.image = user.profilePic
        self.textView.text = String(describing: user!)
    }
    
    func didClickedOnCancel() {
        print("cancelled")
    }
}

