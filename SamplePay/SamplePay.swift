//
//  SamplePay.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 sapphre. All rights reserved.
//

import Foundation
import UIKit

//MARK:- SamplePayError
public enum SamplePayError: Error {
    case rootViewControllerNotSet
}

extension SamplePayError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .rootViewControllerNotSet:
            return NSLocalizedString("Please provide root view controller to Sample Pay", comment: "SamplePayError")
        }
    }
}

//MARK:- SamplePayDelegate
public protocol SamplePayDelegate: AnyObject {
   func didFinishedWithEnteringUserDetails(user: User!)
   func didClickedOnCancel()
}


//MARK:- SamplePayConfigurationOptions
public struct SamplePayConfigurationOptions {
    public weak var rootViewcontroller: UIViewController?
    public weak var delegate: SamplePayDelegate?
    public init(rootViewController: UIViewController?, delegate: SamplePayDelegate?) {
        self.delegate = delegate
        self.rootViewcontroller = rootViewController
    }
}

//MARK:- SamplePay
public class SamplePay {
    
    fileprivate var options: SamplePayConfigurationOptions?
    
    public static let shared = SamplePay.init()
    private init() {}
    
    public func setConfigurationOptions(options: SamplePayConfigurationOptions?) {
        self.options = options
    }
    
    public func enterUserDetails() throws {
        guard let rootVc = options?.rootViewcontroller else {
            throw SamplePayError.rootViewControllerNotSet
        }
        
        let userDetailsEnterVC = EnterUserDetailsTVC.init(style: .plain)
        userDetailsEnterVC.delegate = options?.delegate
        let navController = UINavigationController.init(rootViewController: userDetailsEnterVC)
        navController.navigationBar.tintColor = UIColor.init(red: 0/255.0, green: 234/255.0, blue: 195/255.0, alpha: 1)
         navController.navigationBar.backgroundColor = UIColor.clear
         navController.navigationBar.shadowImage = UIImage()
         navController.navigationBar.isTranslucent = false
        rootVc.present(navController, animated: true, completion: nil)
    }
}
