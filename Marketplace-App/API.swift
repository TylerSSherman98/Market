//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  API.swift
//
//  Created by Tyler Sherman on 11/16/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class API {
    
    let dataURLString = "https://raw.githubusercontent.com/TylerSSherman98/Marketplace-App/master/products.json"
    
    //Retrieves the Data (JSON Format) from the URL
    func getDataFromURL(completion: @escaping (Data?) -> ()) { //Void Function that takes in Data as a parameter
        if let url = URL(string: dataURLString) {
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?)  in
                //Need to account for all possible errors
                if let httpResponse = response as? HTTPURLResponse { //Cast as the specified type
                    if httpResponse.statusCode == 200 {	     //Status Code indicates all clear
                        completion(data)                     //We can now safely use the data
                    }
                }
            } )
            task.resume()
        }
    }
    //Creates the Dictionary from the JSON File
    func dictionaryFromData(data: Data) -> [String:Any] {
        if let jsonSerialization = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let dictionary = jsonSerialization as? [String:Any] { //Trying to cast
                return dictionary
            }
        }
        return [String:Any]() //Base case —> empty dictionary
    }
    //Creates the Items from the Dictionary
    func productsFromDictionary(dictionary: [String:Any]) -> [Product] {
        var products = [Product]()
        if let productArray = dictionary["products"] as? [[String:Any]] {
            for productJson in productArray {
                if let sellerName = productJson["seller_name"] as? String {
                    if let productName = productJson["product_name"] as? String {
                        if let description = productJson["description"] as? String {
                            if let price = productJson["price"] as? String {
                                if let priceConverted = Double(price) {
                                    if let pictureURLString = productJson["picture"] as? String {
                                        let image = getImageFromURLString(urlString: pictureURLString)
                                        products.append(Product(sellerName: sellerName, productName: productName, description: description, price: priceConverted, image: image))
                                    } else {
                                        let image = UIImage(named: "Generic")
                                        products.append(Product(sellerName: sellerName, productName: productName, description: description, price: priceConverted, image: image))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return products
    }
    //Creates the Images from the URL Strings
    func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return UIImage(named: "Generic")    //Guarantess an image
    }
}

