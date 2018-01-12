//
//  CartViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/21.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift

struct CartList {
    let restaurant_id: String
    let meal_id: String
    let meal_name: String
    let price: Int
    let amount: Int
    //let remark: String
    
    init(restaurant_id: String, meal_id: String, meal_name: String, price: String, amount: Int) {
        self.restaurant_id = restaurant_id
        self.meal_id = meal_id
        self.meal_name = meal_name
        self.price = Int(price)!
        self.amount = amount
        //self.remark = remark
    }
}

class CartViewController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sentOrderBtn: UIButton!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var remarkStackView: UIStackView!
    @IBOutlet weak var remarkTextView: UITextView!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    var cartLists = [CartList]()
    var cartDics = Array<Dictionary<String, Any>>()
    
    var totalPrice: Int = 0
    var totalAmount: Int = 0
    var remark = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IQKeyboardManager.sharedManager().disabledToolbarClasses.append(SendOrderViewController.self)
        
        //移除返回按鈕的標題
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "上一步", style: .plain, target: nil, action: nil)
        
        if let cartListResults = defaults.array(forKey: "cartList") {
            //print(cartListResults)
            
            let cartList = cartListResults as! [[String: Any]]
            var cartDic = [String: Any]()
            
            for cartContent in cartList {
                
                let restaurant_id = cartContent["restaurant_id"] as! String
                let meal_id = cartContent["meal_id"] as! String
                let meal_name = cartContent["meal_name"] as! String
                let price = cartContent["price"] as! String
                let amount = cartContent["amount"] as! Int
                //let remark = cartContent["remark"] as! String
                
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
        self.tableView.reloadData()
    }
    
    //MARK: - Order Button
    
    @IBAction func sendOrder(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let sendOrder = storyboard.instantiateViewController(withIdentifier: "SendOrderViewController") as! SendOrderViewController
        self.navigationController?.pushViewController(sendOrder, animated: true)
        
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
        
        switch indexPath.section {
        case 0: //顯示加入購物車的餐點
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartCell
            let Subtotal = (self.cartLists[indexPath.row].amount * self.cartLists[indexPath.row].price)
            cell.mealLabel.text = self.cartLists[indexPath.row].meal_name
            cell.amountLabel.text = "X\(self.cartLists[indexPath.row].amount)"
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
                totalPrice += (meal.price * meal.amount)
                totalAmount += meal.amount
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
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
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
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        if let indexPath = self.tableView.indexPathForSelectedRow {
//            let moveMeal = self.cartLists.remove(at: indexPath.row)
//            self.cartLists.insert(moveMeal, at: indexPath.row)
//
//            self.tableView.reloadData()
//        }
//
//    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableviewEditingMode = self.tableView.isEditing
        
        self.tableView.setEditing(!tableviewEditingMode, animated: true)
    }
    
}
