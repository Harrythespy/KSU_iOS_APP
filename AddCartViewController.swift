//
//  AddCartViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/18.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class AddCartViewController: BaseController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableView: UITableView!
    
    var restaurant: Restaurant!
    var meal: Meal!
    var amount: Int = 1 //初始化數量
    //var remark: String = "" //初始化備註項目
    var cartList = [String: [String: String]]()
    var mealToList = [String: String]() //儲存購物車裡的每筆資料
    //var cartList = Array<Dictionary<String, Any>>() //初始化儲存進userDefaults的二維陣列
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "餐點選項"
        
    }
    
    //MARK: - Table data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "選擇項目"
            
        case 1:
            return "選擇數量"
            
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        switch indexPath.section {
            
        case 0:

            let addCartCell = tableView.dequeueReusableCell(withIdentifier: "AddCartCell", for: indexPath) as! AddCartCell
            addCartCell.mealNmaeLabel.text = self.meal.meal_name
            addCartCell.priceLabel.text = "NT$ \(self.meal.price)"
            
            //cell選擇特效
            addCartCell.selectionStyle = .none
            
            return addCartCell
            
        case 1:
            let addCartCell2 = tableView.dequeueReusableCell(withIdentifier: "AddCartCell2", for: indexPath) as! AddCartCell2
            
            self.amount = Int(addCartCell2.stepper.value)
//            self.tableView.rowHeight = 120
//            //cell選擇特效
//            cell3.selectionStyle = .none
//            cell3.textView.text = self.remark
            
            return addCartCell2
            
        default:

            return UITableViewCell()

        }
    }
    
    func addToUserDefaults() { //將購物車資料加進陣列中
        
        let cell2 = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! AddCartCell2
        self.amount = Int(cell2.stepper.value)
        let amountStr = String(self.amount)
        
        if self.defaults.dictionary(forKey: "cartList") != nil {
            self.cartList = self.defaults.dictionary(forKey: "cartList") as! [String: [String: String]] //如果userdefault的cartList已經存在了，則使用原有資料
            
            self.accumulate() //判斷id是否存在，將相同id的陣列累加
            
            
            self.defaults.set(self.cartList, forKey: "cartList")
            self.defaults.synchronize()
            
        }
        else {
            /*********** 新增一筆資料 ************/
            self.mealToList.updateValue(self.restaurant.restaurant_id, forKey: "restaurant_id")
            self.mealToList.updateValue(self.meal.meal_id, forKey: "meal_id")
            self.mealToList.updateValue(self.meal.meal_name, forKey: "meal_name")
            self.mealToList.updateValue(self.meal.price, forKey: "price")
            self.mealToList.updateValue(amountStr, forKey: "amount")
            //mealToList.updateValue(self.remark, forKey: "remark")
            
            self.cartList.updateValue(self.mealToList, forKey: "\(self.meal.meal_id)") //加入二維陣列中的最後一筆
            
            self.defaults.set(self.cartList, forKey: "cartList")
            self.defaults.synchronize()
//                print(self.cartList)
            /*********** 新增一筆資料 ************/
        }
        
    }
    
    @IBAction func addCart(_ sender: Any) {
        
        addToUserDefaults()
        
        //新增一個alert的動作：進行換頁動作
        let addActionHandler = { (action: UIAlertAction!) -> Void in
            let shoppingCartStoryboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
            let cart = shoppingCartStoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            self.navigationController?.pushViewController(cart, animated: true)
            
        }
        let addAlert = UIAlertController(title: nil, message: "已將\(meal.meal_name)加入購物車", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "確定", style: .default, handler: addActionHandler)
        addAlert.addAction(addAction)
        
        present(addAlert, animated: true, completion: nil)
        
    }
    
    func accumulate() {
        let amountStr = String(self.amount)
        if (self.cartList.index(forKey: self.meal.meal_id) != nil) {
            let amount = Int(self.cartList["\(self.meal.meal_id)"]!["amount"]!)!
            self.cartList["\(self.meal.meal_id)"]!["amount"] = "\(amount + self.amount)"
        }
        else {
            /*********** 新增一筆資料 ************/
            self.mealToList.updateValue(self.restaurant.restaurant_id, forKey: "restaurant_id")
            self.mealToList.updateValue(self.meal.meal_id, forKey: "meal_id")
            self.mealToList.updateValue(self.meal.meal_name, forKey: "meal_name")
            self.mealToList.updateValue(self.meal.price, forKey: "price")
            self.mealToList.updateValue(amountStr, forKey: "amount")
            //mealToList.updateValue(self.remark, forKey: "remark")
            
            self.cartList.updateValue(self.mealToList, forKey: "\(self.meal.meal_id)") //加入二維陣列中的最後一筆
            
            self.defaults.set(self.cartList, forKey: "cartList")
            self.defaults.synchronize()
            //print(self.cartList)
            /*********** 新增一筆資料 ************/
        }
        
    }
    
}
