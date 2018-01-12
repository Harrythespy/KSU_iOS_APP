//
//  RestaurantInfoViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/3.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class RestaurantInfoViewController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = restaurant.name
        self.restaurantImage.sd_setImage(with: URL(string: "http://120.114.101.129/Swift/img/\(self.restaurant.restaurant_id).jpg"), placeholderImage: UIImage(named: "\(self.restaurant.name)"))
    }
    
    //MARK: - TableView data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantInfoTableViewCell
        
        //config cell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "餐廳名稱"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "電話"
            cell.valueLabel.text = restaurant.phone
        case 2:
            cell.fieldLabel.text = "位置"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "營業時間"
            cell.valueLabel.text = "\(restaurant.open_time) ~ \(restaurant.close_time)"
        case 4:
            cell.fieldLabel.text = "簡介"
            cell.valueLabel.text = restaurant.short_info
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        //cell選擇特效
        cell.selectionStyle = .none
        
        return cell
    }
    
    @IBAction func showMenuDetail(_ sender: Any) {
        let mealSelected = UIStoryboard(name: "MealSelected", bundle: nil)
        
        let mealMenu = mealSelected.instantiateViewController(withIdentifier: "MealMenuViewController") as! MealMenuViewController
        mealMenu.restaurant = self.restaurant as Restaurant
        navigationController?.pushViewController(mealMenu, animated: true)
        
    }
    

}
