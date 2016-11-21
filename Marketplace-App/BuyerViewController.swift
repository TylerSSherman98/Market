//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  BuyerViewController.swift
//
//  Created by Tyler Sherman on 11/19/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class BuyerViewController: UIViewController {

    var buyer: Buyer?
    var emailButton: UIButton!
    var phoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        if let nameTitle = buyer?.name {      //Title bar of the UINavigationController
            title = nameTitle
        }
        finishSetup()
    }
    func finishSetup() {
        
        //Creating the Elements
        emailButton = UIButton()
        phoneButton = UIButton()
        
        //Setting up the Elements
        emailButton.setTitleColor(.black, for: .normal)
        emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        emailButton.contentHorizontalAlignment = .left
        emailButton.titleLabel?.adjustsFontSizeToFitWidth = true
        emailButton.setTitle(buyer?.email, for: .normal)
        emailButton.addTarget(self, action: #selector(openEmailApp), for: .touchUpInside)
        phoneButton.setTitleColor(.black, for: .normal)
        phoneButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        phoneButton.contentHorizontalAlignment = .left
        phoneButton.setTitle(buyer?.phoneNumber, for: .normal)
        phoneButton.addTarget(self, action: #selector(openPhoneApp), for: .touchUpInside)
        
        //Creating the Profile Image View
        let profileImageView = UIImageView(frame: CGRect(x: view.frame.width/2 - (view.frame.width*0.5)/2, y: 20, width: view.frame.width*0.5, height: view.frame.width*0.5))
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2    //Rounds edges of image
        profileImageView.image = UIImage(named: "GenericProfilePicture")
        
        //Creating the Name Label
        let nameLabel = UILabel(frame: CGRect(x: view.frame.width*0.1, y: profileImageView.frame.origin.y + profileImageView.frame.height + 10, width: view.frame.width*0.8, height: 60))
        nameLabel.text = buyer?.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 50.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = NSTextAlignment.center
        
        //Creating the Phone Image View
        let phoneImageView = UIImageView(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y+nameLabel.frame.height + 50, width: 30, height: 30))
        phoneImageView.image = UIImage(named: "phone")
        
        //Creating the Email Image View
        let emailImageView = UIImageView(frame: CGRect(x: nameLabel.frame.origin.x, y: phoneImageView.frame.origin.y+phoneImageView.frame.height + 15, width: 30, height: 30))
        emailImageView.image = UIImage(named: "email")

        //Positioning the Elements
        phoneButton.frame = CGRect(x: phoneImageView.frame.origin.x + phoneImageView.frame.width + 10, y: phoneImageView.frame.origin.y, width: view.frame.width*0.8, height: 30)
        emailButton.frame = CGRect(x: emailImageView.frame.origin.x + emailImageView.frame.width + 10, y: emailImageView.frame.origin.y, width: view.frame.width*0.8, height: 30)

        //Adding the Elements to the Subview
        view.addSubview(nameLabel)
        view.addSubview(emailButton)
        view.addSubview(phoneButton)
        view.addSubview(profileImageView)
        view.addSubview(phoneImageView)
        view.addSubview(emailImageView)
    }
    //FUNCTIONS
    func openEmailApp() {
        let email = (buyer?.email)!
        if let url = NSURL(string: "mailto://\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        } else {
            let alertController = UIAlertController(title: "ERROR!", message: "Invalid email address", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    func openPhoneApp() {
        let phoneNumber = "telprompt://\(formatPhoneNumber())"
        if let url = NSURL(string: phoneNumber) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        } else {
            let alertController = UIAlertController(title: "ERROR!", message: "Invalid phone number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    func formatPhoneNumber() -> String {
        let phoneString1 = buyer?.phoneNumber
        let phoneString2 = phoneString1?.replacingOccurrences(of: "(", with: "", options: .literal, range: nil)
        let phoneString3 = phoneString2?.replacingOccurrences(of: ")", with: "", options: .literal, range: nil)
        let phoneString4 = phoneString3?.replacingOccurrences(of: "-", with: "", options: .literal, range: nil)
        let phoneNumberFinal = phoneString4?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        return phoneNumberFinal!
    }
}

