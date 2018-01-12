//
//  RestaurantInfoViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/9/14.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
import PKHUD
import SDWebImage

class RestaurantMenuViewController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private var restaurants = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除返回按鈕的標題
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //變更內容列分隔線顏色
        tableView.separatorColor = UIColor.init(red: 42.0/255.0, green: 152.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        
        parseData()
    }
    
    func parseData() {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        let jsonUrlString = "http://120.114.101.129/Swift/Restaurant.php"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            if (err != nil) {
                print("Error= \(err!)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            
            do {
                
                let restaurantResults = try JSONDecoder().decode([Restaurant].self, from: data)
                
                for restaurant in restaurantResults {
                    let rid = restaurant.restaurant_id
                    let rName = restaurant.name
                    let phone = restaurant.phone
                    let location = restaurant.location
                    let shortInfo = restaurant.short_info
                    let openTime = restaurant.open_time
                    let closeTime = restaurant.close_time
                    let meals = restaurant.meals
                    
                    self.restaurants.append(Restaurant(rid: rid, rName: rName, phone: phone, location: location, shortInfo: shortInfo, openTime: openTime, closeTime: closeTime, meals: meals))
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    PKHUD.sharedHUD.hide()
                }
            }
            catch let jsonErr {
                print("Json Serializing Error:", jsonErr)
            }
        }.resume()
        
    }
    
    //MARK: - Table data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //傳回tableView cell的值
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantTableViewCell
        let restaurant: Restaurant
        
        restaurant = restaurants[indexPath.row]
        
        cell.thumbnailImageView.sd_setImage(with: URL(string: "http://120.114.101.129/Swift/img/\(self.restaurants[indexPath.row].restaurant_id).jpg"), placeholderImage: UIImage(named: "\(self.restaurants[indexPath.row].name)"))
        cell.nameLabel?.text = restaurant.name
        cell.shortInfoLabel?.text = restaurant.short_info
        
        cell.thumbnailImageView.layer.cornerRadius = 10.0
        //圖片圓形
        cell.thumbnailImageView.clipsToBounds = true
        //cell選擇特效
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let restaurantInfo = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantInfoViewController") as! RestaurantInfoViewController
        navigationController?.pushViewController(restaurantInfo, animated: true)
        restaurantInfo.restaurant = restaurants[(indexPath.row)] as Restaurant
        
    }
    
    //MARK: - Segue
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showRestaurantInfo" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let destinationController = segue.destination as! RestaurantInfoViewController
//                destinationController.restaurant = restaurants[indexPath.row]
//            }
//        }
//    }

}
