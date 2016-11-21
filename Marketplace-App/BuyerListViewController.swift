//  CS 1998: CUAppDev Introduction to iOS App Development
//  Marketplace-App
//  BuyerListViewController.swift
//
//  Created by Tyler Sherman on 11/21/16.
//  Copyright © 2016 Tyler Sherman. All rights reserved.
//

import UIKit

class BuyerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var buyerList = [Buyer]()             
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Buyer List"
        view.backgroundColor = .white           //Background color of the view
        
        //Initializing the Table
        tableView = UITableView(frame: view.frame)
        tableView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        tableView.tableFooterView = UIView()        //Gets rid of extra lines
        tableView.separatorColor = .brown
        tableView.rowHeight = 125                   //Generic height for all cells
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BuyerTableViewCell.self, forCellReuseIdentifier: "Reuse")
        view.addSubview(tableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyerList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse") as? BuyerTableViewCell { //Is it able to CAST? --> yes
            let buyer = buyerList[indexPath.row]
            cell.setup(name: buyer.name, phoneNumber: buyer.phoneNumber, email: buyer.email, product: buyer.product!)
            return cell
        }
        return BuyerTableViewCell(style: .default, reuseIdentifier: "Reuse") //Never executed but satisfies the compiler
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  //UITableViewDelegate (OPTIONAL function)
        let buyer = buyerList[indexPath.row]
        let buyerViewController = BuyerViewController()
        buyerViewController.buyer = buyer
        navigationController?.pushViewController(buyerViewController, animated: true)
    }
}

