//
//  User.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import Foundation

public class User {
    public var firstName: String?
    public var lastName: String?
    public var profilePic: String?
    public var mobile: String?
    public var email: String?
    
    public var fullName: String {
        var name = ""
        if let firstName = firstName, !firstName.isEmpty {
            name += "\(firstName) "
        }
        if let lastName = lastName, !lastName.isEmpty {
            name += "\(lastName)"
        }
        return name
    }
}
