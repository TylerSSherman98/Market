//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  CollectionViewController.swift
//
//  Created by Tyler Sherman on 11/21/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, updateBuyerListDelegate2 {

    var collectionView: UICollectionView!
    var products = [Product]()
    var buyerList = [Buyer]()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor(colorLiteralRed: 76/255, green: 130/255, blue: 188/255, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black //makes text white in navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 76/255, green: 130/255, blue: 188/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        title = "Marketplace"
        
        //Create a BuyerList Button
        let rightBarButton = UIBarButtonItem(title: "Buyer List", style: .plain, target: self, action: #selector(buyerListWasTapped))
        navigationItem.rightBarButtonItem = rightBarButton      //Adding a bar button to the upper right-hand corner

        //Activity Indicator
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.frame = CGRect(x: self.view.frame.width/2-20, y: self.view.frame.height/2-100, width: 80, height: 80)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        //Creating the Collection View
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-70), collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "Reuse")
        collectionView.backgroundColor = UIColor(colorLiteralRed: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionViewInsets = UIEdgeInsetsMake(5.0, 4.0, 5.0, 4.0);
        collectionView.contentInset = collectionViewInsets
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(collectionViewInsets.top, 0, collectionViewInsets.bottom, 0);
        //Adds Pull to Refresh Functionality
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged) //Called whenever pulled down
        collectionView.refreshControl = refreshControl
        
        let api = API()
        activityIndicator.startAnimating()  //Ends when products are displayed on screen
        api.getDataFromURL { (data: Data?) in
            if let unwrappedData = data {
                let dictionary = api.dictionaryFromData(data: unwrappedData)
                let products = api.productsFromDictionary(dictionary: dictionary)
                //Inside function so doesn't matter that it's same name as class level variable
                self.products = products
                self.finishSetup()
            }
        }
    }
    
    //FUNCTIONS
    func finishSetup() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.view.addSubview(self.collectionView)
        }
    }
    func pullToRefresh () {
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    func buyerListWasTapped() {
        let buyerListViewController = BuyerListViewController()
        buyerListViewController.buyerList = buyerList
        navigationController?.pushViewController(buyerListViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reuse", for: indexPath) as! ProductCollectionViewCell
        //Returns reusable cell that isn't being used anymore
        let product = products[indexPath.row]
        cell.setup(productImage: product.image!, productName: product.productName, productPriceFormatted: product.priceFormatted)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let seperator: CGFloat = 8.0 * 1.0 + 4.0*2.0
        let size = (view.frame.width - seperator)/2.0
        return CGSize(width: size, height: size*1.1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]                                 //Gets Product at specific place in array
        let detailViewController = DetailViewController()
        detailViewController.product = product
        detailViewController.delegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    func updateBuyerList(buyer: Buyer) {
        buyerList.append(buyer)
    }
}
