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
    var amount: Int = 1
    var remark: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "餐點選項"
        
        print("get \(meal.meal_name)!")
        
        //print("get \(restaurant.name)!")
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

            cell2.amountLabel.text = String(self.amount)
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
    
    @IBAction func addCart(_ sender: Any) {
        
        let addActionHandler = { (action: UIAlertAction!) -> Void in
            let shoppingCartStoryboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
            let cart = shoppingCartStoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            self.navigationController?.pushViewController(cart, animated: true)
            cart.meal = self.meal
            cart.amount = self.amount
            cart.remark = self.remark
        }
        let addAlert = UIAlertController(title: nil, message: "已將\(meal.meal_name)加入購物車", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "確定", style: .default, handler: addActionHandler)
        addAlert.addAction(addAction)
        
        present(addAlert, animated: true, completion: nil)
        
    }
}
