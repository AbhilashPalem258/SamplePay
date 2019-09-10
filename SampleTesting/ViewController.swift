//
//  ViewController.swift
//  SampleTesting
//
//  Created by sapphre on 10/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit
import SamplePay

class ViewController: UIViewController {
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
extension ViewController: SamplePayDelegate {
    func didFinishedWithEnteringUserDetails(user: User!) {
        print(user.fullName)
    }
    
    func didClickedOnCancel() {
        print("cancelled")
    }
}

