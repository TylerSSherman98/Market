//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  CheckoutViewController.swift
//
//  Created by Tyler Sherman on 11/16/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

protocol updateBuyerListDelegate {
    func updateBuyerList(buyer: Buyer)
}

import UIKit

class CheckoutViewController: UIViewController {

    var product: Product?
    var nameTextField: UITextField!
    var phoneNumberTextField: UITextField!
    var emailTextField: UITextField!
    var delegate: updateBuyerListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        title = "Checkout"
        
        let w = view.frame.width
        let h = view.frame.height
        
        //Creating the Name Label
        let nameLabel = UILabel(frame: CGRect(x: (view.frame.width-(view.frame.width-100))/2, y: view.frame.height * 0.05, width: view.frame.width-100, height: 40))
        nameLabel.text = "Name"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(nameLabel)
        //Creating the Name TextField
        nameTextField = UITextField(frame: CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.height, width: view.frame.width-100, height: 40))
        nameTextField.backgroundColor = UIColor.white
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.textColor = .blue
        view.addSubview(nameTextField)
        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        nameTextField.leftView = namePaddingView;
        nameTextField.leftViewMode = UITextFieldViewMode.always
        nameTextField.placeholder = "John Smith"
        
        //Creating the Phone Number Label
        let phoneNumberLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: nameTextField.frame.origin.y + nameTextField.frame.height + 25, width: view.frame.width-100, height: 40))
        phoneNumberLabel.text = "Phone Number"
        phoneNumberLabel.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(phoneNumberLabel)
        //Creating the Phone Number TextField
        phoneNumberTextField = UITextField(frame: CGRect(x: nameLabel.frame.origin.x, y: phoneNumberLabel.frame.origin.y + phoneNumberLabel.frame.height, width: view.frame.width-100, height: 40))
        phoneNumberTextField.backgroundColor = UIColor.white
        phoneNumberTextField.layer.cornerRadius = 10.0
        phoneNumberTextField.layer.borderWidth = 1.0
        phoneNumberTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumberTextField.textColor = .blue
        view.addSubview(phoneNumberTextField)
        let phoneNumberPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        phoneNumberTextField.leftView = phoneNumberPaddingView;
        phoneNumberTextField.leftViewMode = UITextFieldViewMode.always
        phoneNumberTextField.placeholder = "1234567890"
        phoneNumberTextField.keyboardType = UIKeyboardType.numberPad
        
        //Creating the Email Label
        let emailLabel = UILabel(frame: CGRect(x: nameLabel.frame.origin.x, y: phoneNumberTextField.frame.origin.y + phoneNumberTextField.frame.height + 25, width: view.frame.width-100, height: 40))
        emailLabel.text = "Email"
        emailLabel.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(emailLabel)
        //Creating the Email TextField
        emailTextField = UITextField(frame: CGRect(x: nameLabel.frame.origin.x, y: emailLabel.frame.origin.y + emailLabel.frame.height, width: view.frame.width-100, height: 40))
        emailTextField.backgroundColor = UIColor.white
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.textColor = .blue
        view.addSubview(emailTextField)
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        emailTextField.leftView = emailPaddingView;
        emailTextField.leftViewMode = UITextFieldViewMode.always
        emailTextField.placeholder = "email@email.com"
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        
        //Creating the Complete Transaction Button
        let completeTransactionButton = UIButton(frame: CGRect(x: 40, y: h-130, width: w - 80, height: 40))
        completeTransactionButton.backgroundColor = .red
        completeTransactionButton.layer.cornerRadius = 20.0
        completeTransactionButton.setTitle("COMPLETE TRANSACTION", for: UIControlState.normal)
        completeTransactionButton.setTitleColor(.white, for: UIControlState.normal)
        completeTransactionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        completeTransactionButton.addTarget(self, action: #selector(completeTransaction), for: .touchUpInside)
        view.addSubview(completeTransactionButton)
    }
    
    //FUNCTIONS
    func completeTransaction() {
        let name = nameTextField.text
        let phoneNumber = phoneNumberTextField.text
        let email = emailTextField.text
        if let buyerName = name, let buyerPhoneNumber = phoneNumber, let buyerEmail = email {
            let validPhoneNumber = validatePhoneNumber(phoneNumber: buyerPhoneNumber)
            if name != "" && email != "" && validPhoneNumber {
                let phoneStringFormatted = NSMutableString(string: buyerPhoneNumber)
                phoneStringFormatted.insert("(", at: 0)
                phoneStringFormatted.insert(")", at: 4)
                phoneStringFormatted.insert(" ", at: 5)
                phoneStringFormatted.insert("-", at: 9)
                let phoneNumberFinal = String(phoneStringFormatted)
                let newBuyer = Buyer(name: buyerName, phoneNumber: phoneNumberFinal, email: buyerEmail, product: self.product)
                delegate?.updateBuyerList(buyer: newBuyer)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "ERROR!", message: "One or more required fields were left blank or filled incorrectly", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "ERROR!", message: "One or more required fields were left blank or filled incorrectly", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    func validatePhoneNumber(phoneNumber: String) -> Bool {
        if phoneNumber.characters.count == 10 {
            return true
        }
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

