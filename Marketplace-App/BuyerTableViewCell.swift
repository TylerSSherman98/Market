//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  BuyerTableViewCell.swift
//
//  Created by Tyler Sherman on 11/16/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class BuyerTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var productNameLabel: UILabel!
    var productPriceLabel: UILabel!
    var phoneImageView: UIImageView!
    var emailImageView: UIImageView!
    var phoneNumberLabel: UILabel!
    var emailLabel: UILabel!
    var purchasedProduct: Product!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)      //If stopped here, would be exactly the same as normal
        
        backgroundColor = .white     //Don't need view.backgroundColor because UITableViewCell IS a view --> setting its properties
        selectionStyle = .none       //Don't turn gray when selected
        
        //Initializing the Elements
        nameLabel = UILabel()
        productNameLabel = UILabel()
        productPriceLabel = UILabel()
        phoneImageView = UIImageView()
        emailImageView = UIImageView()
        phoneNumberLabel = UILabel()
        emailLabel = UILabel()
        
        //Setting up the Labels
        nameLabel.textColor = UIColor.black.withAlphaComponent(0.8) //Alpha = transparency, value from [0.0 - 1.0]
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        productNameLabel.textColor = UIColor.red.withAlphaComponent(0.8)
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        productPriceLabel.textColor = UIColor(colorLiteralRed: 21/255, green: 138/255, blue: 12/255, alpha: 1.0)
        productPriceLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        productPriceLabel.textAlignment = NSTextAlignment.right
        phoneNumberLabel.textColor = UIColor.black.withAlphaComponent(1.0)
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 15.0)
        emailLabel.textColor = UIColor.black.withAlphaComponent(1.0)
        emailLabel.font = UIFont.systemFont(ofSize: 15.0)
        emailLabel.adjustsFontSizeToFitWidth = true
        
        //Adding the Elements to the Subview
        addSubview(nameLabel)
        addSubview(productPriceLabel)
        addSubview(phoneImageView)
        addSubview(emailImageView)
        addSubview(phoneNumberLabel)
        addSubview(emailLabel)
        addSubview(productNameLabel)
    }
    //Required but useless
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()  //Gets all the code we miss
        
        nameLabel.frame = CGRect(x: 10, y: frame.height*0.02, width: frame.width - 20, height: frame.height*0.4)
        productNameLabel.frame = CGRect(x: 10, y: nameLabel.frame.origin.y+nameLabel.frame.height-10, width: frame.width*0.55, height: frame.height*0.3)
        phoneImageView.frame = CGRect(x: 10, y: productNameLabel.frame.origin.y + productNameLabel.frame.height, width: frame.height * 0.15, height: frame.height * 0.15)
        emailImageView.frame = CGRect(x: 10, y: phoneImageView.frame.origin.y + phoneImageView.frame.height+5, width: frame.height * 0.15, height: frame.height * 0.15)
        phoneNumberLabel.frame = CGRect(x: phoneImageView.frame.origin.x + phoneImageView.frame.width + 5, y: phoneImageView.frame.origin.y, width: frame.width*0.55, height: frame.height * 0.15)
        emailLabel.frame = CGRect(x: emailImageView.frame.origin.x + emailImageView.frame.width + 5, y: emailImageView.frame.origin.y-1, width: phoneNumberLabel.frame.width, height: frame.height * 0.17)
        productPriceLabel.frame = CGRect(x: emailLabel.frame.origin.x+emailLabel.frame.width, y: productNameLabel.frame.origin.y+productNameLabel.frame.height+10, width: frame.width - (emailLabel.frame.origin.x+emailLabel.frame.width) - 5, height: frame.height*0.3)
    }
    func setup(name: String, phoneNumber: String, email: String, product: Product) {
        nameLabel.text = name
        self.purchasedProduct = product
        productNameLabel.text = purchasedProduct.productName
        productPriceLabel.text = purchasedProduct.priceFormatted
        phoneNumberLabel.text = phoneNumber
        emailLabel.text = email
        phoneImageView.image = UIImage(named: "phone")
        emailImageView.image = UIImage(named: "email")
    }
}

