//
//  CartViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/21.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

struct CartList {
    let restaurant_id: String
    let meal_id: String
    let meal_name: String
    let price: Int
    let amount: Int
    let remark: String
    
    init(restaurant_id: String, meal_id: String, meal_name: String, price: String, amount: Int, remark: String) {
        self.restaurant_id = restaurant_id
        self.meal_id = meal_id
        self.meal_name = meal_name
        self.price = Int(price)!
        self.amount = amount
        self.remark = remark
    }
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let defaults: UserDefaults = UserDefaults.standard
    
    var cartLists = [CartList]()
    var totalPrice: Int = 0
    var totalAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cartListResults = defaults.array(forKey: "cartList") {
            print(cartListResults)
            
            let cartList = cartListResults as! [[String: Any]]
            
            for cartContent in cartList {
                
                let restaurant_id = cartContent["restaurant_id"] as! String
                let meal_id = cartContent["meal_id"] as! String
                let meal_name = cartContent["meal_name"] as! String
                let price = cartContent["price"] as! String
                let amount = cartContent["amount"] as! Int
                let remark = cartContent["remark"] as! String
            
                self.cartLists.append(CartList(restaurant_id: restaurant_id, meal_id: meal_id, meal_name: meal_name, price: price, amount: amount, remark: remark))
            }
            
        }
        
    }

    //MARK: - Table Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return cartLists.count
            
        case 1:
            return 1
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: //顯示加入購物車的餐點
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartCell
            let Subtotal = (self.cartLists[indexPath.row].amount * self.cartLists[indexPath.row].price)
            cell.mealLabel.text = self.cartLists[indexPath.row].meal_name
            cell.amountLabel.text = "X\(self.cartLists[indexPath.row].amount)"
            cell.priceLabel.text = "NT$ \(Subtotal)"
            
            
            return cell
        case 1: // 顯示總金額及總數量
            let totalCell = tableView.dequeueReusableCell(withIdentifier: "TotalCell", for: indexPath) as! CartTotalCell
            self.totalAmount = 0
            self.totalPrice = 0
            
            for meal in cartLists {
                totalPrice += (meal.price * meal.amount)
                totalAmount += meal.amount
            }
            
            totalCell.totalAmountLabel.text = "X \(totalAmount)"
            totalCell.totalPriceLabel.text = "NT$ \(totalPrice)"
            
            return totalCell
        default:
            return UITableViewCell()
        }
    }
    
}
