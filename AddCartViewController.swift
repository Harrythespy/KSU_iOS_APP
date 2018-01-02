//
//  AddCartViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/18.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class AddCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableView: UITableView!
    
    var restaurant: Restaurant!
    var meal: Meal!
    var amount: Int = 1 //初始化數量
    var remark: String = "" //初始化備註項目
    var cartList = Array<Any>() //初始化儲存進userDefaults的二維陣列
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "餐點選項"
    }
    
    //MARK: - Table data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
        
        case 2:
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
        
        case 2:
            return "餐點備註項目"
            
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        switch indexPath.section {
        case 0:

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddCartCell
            
            cell.mealNmaeLabel.text = self.meal.meal_name
            cell.priceLabel.text = "NT$ \(self.meal.price)"
            
            //cell選擇特效
            cell.selectionStyle = .none
            
            return cell
            
        case 1:

            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! AddCartCell2
            
            
            self.amount = Int(cell2.stepper.value)
            //cell選擇特效
            cell2.selectionStyle = .none
            
            return cell2
            
        case 2:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! AddCartCell3
            
            self.tableView.rowHeight = 120
            //cell選擇特效
            cell3.selectionStyle = .none
            cell3.textView.text = self.remark
            
            return cell3
            
        default:

            return UITableViewCell()

        }
    }
    
    func addToUserDefaults() {
        //將購物車資料加進陣列中
        var mealToList = [String: Any]() //儲存購物車裡的每筆資料
        
        if  defaults.array(forKey: "cartList") != nil {
            //self.cartList.append(mealToList) //加入二維陣列中的最後一筆
            self.cartList = defaults.array(forKey: "cartList")!
        }
    
        let cell2 = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! AddCartCell2
        self.amount = Int(cell2.stepper.value)
        
        //print(self.amount)
        mealToList.updateValue(self.restaurant.restaurant_id, forKey: "restaurant_id")
        mealToList.updateValue(self.meal.meal_id, forKey: "meal_id")
        mealToList.updateValue(self.meal.meal_name, forKey: "meal_name")
        mealToList.updateValue(self.meal.price, forKey: "price")
        mealToList.updateValue(self.amount, forKey: "amount")
        mealToList.updateValue(self.remark, forKey: "remark")
    
        self.cartList.append(mealToList) //加入二維陣列中的最後一筆
        
        defaults.set(cartList, forKey: "cartList")
        self.defaults.synchronize()
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
    
    
    
}
