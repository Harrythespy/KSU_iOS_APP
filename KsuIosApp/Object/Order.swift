//
//  Order.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/9/19.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

class Order: Decodable {
    var order_id: String
    var ksuid: String
    var order_time: String
    var status: String
    var order_detail: [OrderDetail]
    
    init(order_id: String, ksuid: String, order_time: String, status: String, order_detail: [OrderDetail]) {
        
        self.order_id = order_id
        self.ksuid = ksuid
        self.order_time = order_time
        self.status = status
        self.order_detail = order_detail
        
    }
}

class OrderDetail: Decodable {
    
    let od_id: String
    let meal_id: String
    let meal_name: String
    let price: String
    let amount: String
    let restaurant_id: String
    let name: String
}
