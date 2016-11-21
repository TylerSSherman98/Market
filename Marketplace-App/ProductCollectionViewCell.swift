//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  ProductCollectionViewCell.swift
//
//  Created by Tyler Sherman on 11/21/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var productImageView: UIImageView!
    var productNameLabel: UILabel!
    var productPriceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white     //Don't need view.backgroundColor because UITableViewCell IS a view --> setting its properties
        layer.cornerRadius = frame.width/25
        
        //Initializing the Elements
        productImageView = UIImageView()
        productNameLabel = UILabel()
        productPriceLabel = UILabel()
        
        //Setting up the Labels
        productNameLabel.textColor = UIColor.black.withAlphaComponent(1.0) //Alpha = transparency, value from [0.0 - 1.0]
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        productNameLabel.adjustsFontSizeToFitWidth = true
        let moneyColor = UIColor(colorLiteralRed: 21/255, green: 138/255, blue: 12/255, alpha: 1.0)
        productPriceLabel.textColor = moneyColor
        productPriceLabel.font = UIFont.systemFont(ofSize: 18.0)
        
        //Setting up the Product Image
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFit
        
        //Adding the Elements to the Subview
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
    }
    //Required but useless
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()  //Gets all the code we miss
        
        productImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height*0.7)

        productNameLabel.frame = CGRect(x: 10, y: productImageView.frame.height+5, width: frame.width-15, height: frame.height*0.15)
        
        productPriceLabel.frame = CGRect(x: 10, y: productNameLabel.frame.origin.y+productNameLabel.frame.height-7, width: frame.width-15, height: frame.height*0.15)
    }
    func setup(productImage: UIImage, productName: String, productPriceFormatted: String) {
        productImageView.image = productImage
        productNameLabel.text = productName
        productPriceLabel.text = productPriceFormatted
    }
}

