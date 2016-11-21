//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  Buyer.swift
//
//  Created by Tyler Sherman on 11/21/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class Buyer {
    
    var name: String
    var phoneNumber: String
    var email: String
    var product: Product?
        
    init(name: String, phoneNumber: String, email: String, product: Product?) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.product = product
    }
}

