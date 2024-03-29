//
//  MealMenuViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/3.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class MealMenuViewController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除返回按鈕的標題
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        title = restaurant.name
    
    }
    
    //MARK: - TableView data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.meals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MealMenuTableViewCell
        let meal = restaurant.meals[indexPath.row]
        
        cell.mealNameLabel.text = meal.meal_name
        cell.smallTypeLabel.text = meal.small_type
        cell.priceLabel.text = meal.price
        cell.meal = meal
        cell.restaurant = restaurant
        
        cell.navigationController = self.navigationController!
        cell.cellStoryboard = self.storyboard!
        
        //cell選擇特效
        cell.selectionStyle = .none
        
        return cell
    }
    
}

