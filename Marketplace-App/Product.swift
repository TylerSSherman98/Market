//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  Product.swift
//
//  Created by Tyler Sherman on 11/21/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class Product {

    var sellerName: String
    var productName: String
    var description: String
    var price: Double
    var priceFormatted: String
    var image: UIImage?
    
    init(sellerName: String, productName: String, description: String, price: Double, image: UIImage?) {
        self.sellerName = sellerName
        self.productName = productName
        self.description = description
        self.price = price
        self.priceFormatted = ""
        self.image = image
        formatPrice()
    }
    func formatPrice() {
        let priceConverted = price as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let finalProductPrice = formatter.string(from: priceConverted)
        self.priceFormatted = finalProductPrice!
    }
}

