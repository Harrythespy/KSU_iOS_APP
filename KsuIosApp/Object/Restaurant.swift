//
//  Restaurant.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/9/13.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

class Restaurant: Decodable {
    
    var restaurant_id: String
    var name: String
    var phone: String
    var location: String
    var short_info: String
    var open_time: String
    var close_time: String
    var meals: [Meal]
    
    init(rid: String, rName: String, phone: String, location: String, shortInfo: String, openTime: String, closeTime: String, meals: [Meal]) {
        self.restaurant_id = rid
        self.name = rName
        self.phone = phone
        self.location = location
        self.short_info = shortInfo
        self.open_time = openTime
        self.close_time = closeTime
        self.meals = meals
    }
    
}

class Meal: Decodable {
    
    var meal_id: String
    var meal_name: String
    var small_type: String
    var price: String
    
    init(mealId: String, mealName: String, type: String, price: String) {
        self.meal_id = mealId
        self.meal_name = mealName
        self.small_type = type
        self.price = price
    }

}
