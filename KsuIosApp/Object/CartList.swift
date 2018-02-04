//
//  CartList.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2018/1/16.
//  Copyright © 2018年 Harry Shen. All rights reserved.
//

struct CartList: Codable {
    let restaurant_id: String
    let meal_id: String
    let meal_name: String
    let price: String
    let amount: String
    //let remark: String

    init(restaurant_id: String, meal_id: String, meal_name: String, price: String, amount: String) {
        self.restaurant_id = restaurant_id
        self.meal_id = meal_id
        self.meal_name = meal_name
        self.price = price
        self.amount = amount
        //self.remark = remark
    }
}

