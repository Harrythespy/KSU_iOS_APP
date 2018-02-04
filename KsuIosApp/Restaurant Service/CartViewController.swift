//
//  CartViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/21.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift

class CartViewController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sentOrderBtn: UIButton!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var remarkStackView: UIStackView!
    @IBOutlet weak var remarkTextView: UITextView!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    var cartLists = [CartList]()
    var cartDics = Array<Dictionary<String, String>>()
    
    var totalPrice: Int = 0
    var totalAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除返回按鈕的標題
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "上一步", style: .plain, target: nil, action: nil)
        
        if self.defaults.dictionary(forKey: "cartList") != nil {
            var cartListResults = self.defaults.dictionary(forKey: "cartList") as! [String: [String: Any]]
            
            let cartListArr = Array(cartListResults.keys)
            //let cartList = cartListResults as! [String: [String: Any]]
            var cartDic = [String: String]()
            
            for cartContent in cartListArr {

                let restaurant_id = cartListResults["\(cartContent)"]!["restaurant_id"] as! String
                let meal_id = cartListResults["\(cartContent)"]!["meal_id"] as! String
                let meal_name = cartListResults["\(cartContent)"]!["meal_name"] as! String
                let price = cartListResults["\(cartContent)"]!["price"] as! String
                let amount = cartListResults["\(cartContent)"]!["amount"] as! String
                
                self.cartLists.append(CartList(restaurant_id: restaurant_id, meal_id: meal_id, meal_name: meal_name, price: price, amount: amount))
                cartDic.updateValue(restaurant_id, forKey: "restaurant_id")
                cartDic.updateValue(meal_id, forKey: "meal_id")
                cartDic.updateValue(meal_name, forKey: "meal_name")
                cartDic.updateValue(price, forKey: "price")
                cartDic.updateValue(amount, forKey: "amount")
                self.cartDics.append(cartDic)
            }
            
        }
        if self.cartLists.count == 0 {
            self.sentOrderBtn.isHidden = true
            self.remarkStackView.isHidden = true
            self.editBtn.isEnabled = false
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK: - Order Button
    
    @IBAction func sendOrder(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let sendOrder = storyboard.instantiateViewController(withIdentifier: "SendOrderViewController") as! SendOrderViewController
        self.navigationController?.pushViewController(sendOrder, animated: true)
        sendOrder.cartList = self.cartLists
        sendOrder.price = self.totalPrice
        sendOrder.amount = self.totalAmount
    }
    

    //MARK: - Table Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if self.cartLists.count != 0 {
            tableView.separatorStyle = .singleLine
            numOfSections = 2
            tableView.backgroundView = nil
        }
        else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "目前沒有餐點"
            noDataLabel.textColor = UIColor.gray
            noDataLabel.font = UIFont(name: "Avenir Next", size: 28)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return cartLists.count
            
        case 1:
            if self.cartLists.count == 0 {
                return 0
            }
            return 1
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let amount = Int(self.cartLists[indexPath.row].amount)!
        let price = Int(self.cartLists[indexPath.row].price)!
        
        switch indexPath.section {
        case 0: //顯示加入購物車的餐點
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartCell
            let Subtotal = (amount * price)
            cell.mealLabel.text = self.cartLists[indexPath.row].meal_name
            cell.amountLabel.text = "X\(amount)"
            cell.priceLabel.text = "NT$ \(Subtotal)"
            
            cell.showsReorderControl = true
            cell.backgroundColor = UIColor.clear
            self.tableView.rowHeight = 60
            
            return cell
        case 1: // 顯示總金額及總數量
            let totalCell = self.tableView.dequeueReusableCell(withIdentifier: "TotalCell", for: indexPath) as! CartTotalCell
            self.totalAmount = 0
            self.totalPrice = 0
            
            for meal in cartLists {
                let mealPrice = Int(meal.price)!
                let mealAmount = Int(meal.amount)!
                totalPrice += (mealPrice * mealAmount)
                totalAmount += mealAmount
            }
            
            totalCell.totalAmountLabel.text = "X \(totalAmount)"
            totalCell.totalPriceLabel.text = "NT$ \(totalPrice)"
            
            totalCell.backgroundColor = UIColor.clear
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
            self.tableView.rowHeight = 65
            
            return totalCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.cartLists.remove(at: indexPath.row) //若滑動的按鈕選擇刪除，將資料列刪除
            self.cartDics.remove(at: indexPath.row) //若滑動的按鈕選擇刪除，將資料列刪除
            //self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.defaults.set(self.cartDics, forKey: "cartList") //刪除後將新的陣列存入cartList中
            self.defaults.synchronize() //將資料寫進userDefault中
            
            self.tableView.reloadData() //重整列表
        }
        
        if self.cartLists.count == 0 {
            self.sentOrderBtn.isHidden = true //如果陣列沒有資料，隱藏送出按鈕
            self.remarkStackView.isHidden = true
            self.editBtn.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        switch indexPath.section { //switch判斷可進行修改的section
        case 0: //購物車的內容cell所以可以修改
            return true
        case 1: //加總的cell，不能修改
            return false
        default:
            return false
        }
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        if self.editBtn.title == "編輯" {
            self.editBtn.title = "完成"
        }
        else {
            self.editBtn.title = "編輯"
        }
        
        let tableviewEditingMode = self.tableView.isEditing
        self.tableView.setEditing(!tableviewEditingMode, animated: true)
    }
    
//    func hideKeyboard()
//    {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(dismissKeyboard))
//
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
}
