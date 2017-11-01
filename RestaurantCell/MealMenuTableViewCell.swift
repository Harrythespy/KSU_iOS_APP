//
//  MealMenuTableViewCell.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/3.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class MealMenuTableViewCell: UITableViewCell {

    @IBOutlet var thumnailImageView: UIImageView!
    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var smallTypeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var cellStoryboard = UIStoryboard()
    var navigationController = UINavigationController()
    var restaurant: Restaurant!
    var meal: Meal!
    
    @IBAction func addCart(_ sender: Any) {
        
        let addCart = self.cellStoryboard.instantiateViewController(withIdentifier: "AddCartViewController") as! AddCartViewController
        //addCart.restaurant = self.restaurant as Restaurant
        addCart.meal = self.meal as Meal
        self.navigationController.pushViewController(addCart, animated: true)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
