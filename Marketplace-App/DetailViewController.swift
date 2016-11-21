//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  DetailViewController.swift
//
//  Created by Tyler Sherman on 11/21/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

protocol updateBuyerListDelegate2 {
    func updateBuyerList(buyer: Buyer)
}

import UIKit

class DetailViewController: UIViewController, updateBuyerListDelegate {

    var product: Product?
    var purchaseButton: UIButton!
    var delegate: updateBuyerListDelegate2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        if let nameTitle = product?.productName {      //Title bar of the UINavigationController
            title = nameTitle
        }
        finishSetup()
    }
    
    //FUNCTIONS
    func finishSetup() {
        
        let w = view.frame.width
        let h = view.frame.height
        
        //Creating the Product Name Label
        let productNameLabel = UILabel(frame: CGRect(x: 10, y: h*0.05, width: w - 20, height: 50))
        productNameLabel.text = product?.productName
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        productNameLabel.textAlignment = NSTextAlignment.center
        
        //Creating the Seller Name Label
        let sellerNameLabel = UILabel(frame: CGRect(x: 10, y: productNameLabel.frame.origin.y+productNameLabel.frame.height, width: w - 20, height: 30))
        sellerNameLabel.text = "Sold by: "+(product?.sellerName)!
        sellerNameLabel.font = UIFont.systemFont(ofSize: 15.0)
        sellerNameLabel.textAlignment = NSTextAlignment.center
        
        //Creating the Product Image View
        let productImageView = UIImageView(frame: CGRect(x: 40, y: sellerNameLabel.frame.origin.y+sellerNameLabel.frame.height+10, width: w - 80, height: w - 120))
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = productImageView.frame.width/20    //Rounds edges of image
        productImageView.image = product?.image
        
        //Creating the Product Description Text View
        let productDescriptionTextView = UITextView(frame: CGRect(x: 10, y: productImageView.frame.origin.y+productImageView.frame.height+10 , width: w - 20, height: 60))
        productDescriptionTextView.text = product?.description
        productDescriptionTextView.font = UIFont.systemFont(ofSize: 20)
        productDescriptionTextView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        productDescriptionTextView.textAlignment = NSTextAlignment.center
        productDescriptionTextView.isEditable = false
        productDescriptionTextView.clipsToBounds = true
        let contentSize = productDescriptionTextView.sizeThatFits(productDescriptionTextView.bounds.size)
        var frame = productDescriptionTextView.frame
        frame.size.height = contentSize.height
        productDescriptionTextView.frame = frame
        //VERTICAL ALLIGNMENT --> not needed since change height of UITextView to fit the content size
        //var top = (productDescriptionTextView.bounds.size.height - productDescriptionTextView.contentSize.height * productDescriptionTextView.zoomScale) / 2.0
        //top = top < 0.0 ? 0.0 : top
        //productDescriptionTextView.contentOffset = CGPoint(x: productDescriptionTextView.contentOffset.x, y: -top)
        
        //Creating the Product Price Label
        let productPriceLabel = UILabel(frame: CGRect(x: 10, y: productDescriptionTextView.frame.origin.y+productDescriptionTextView.frame.height - 5, width: w - 20, height: 40))
        productPriceLabel.text = product?.priceFormatted
        productPriceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        productPriceLabel.textColor = UIColor(colorLiteralRed: 21/255, green: 138/255, blue: 12/255, alpha: 1.0)
        productPriceLabel.textAlignment = NSTextAlignment.center

        //Creating the Purchase Button
        purchaseButton = UIButton(frame: CGRect(x: 40, y: h-130, width: w - 80, height: 40))
        purchaseButton.backgroundColor = .blue
        purchaseButton.layer.cornerRadius = 20.0
        purchaseButton.setTitle("ADD TO CART", for: UIControlState.normal)
        purchaseButton.setTitleColor(.white, for: UIControlState.normal)
        purchaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        purchaseButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        //Adding the Elements to the Subview
        view.addSubview(sellerNameLabel)
        view.addSubview(productNameLabel)
        view.addSubview(productImageView)
        view.addSubview(productDescriptionTextView)
        view.addSubview(productPriceLabel)
        view.addSubview(purchaseButton)
    }
    func addToCart() {
        let checkoutViewController = CheckoutViewController()
        checkoutViewController.product = product
        checkoutViewController.delegate = self
        navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    func updateBuyerList(buyer: Buyer) {
        delegate?.updateBuyerList(buyer: buyer)
    }
}

