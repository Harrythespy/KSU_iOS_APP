//
//  User.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/14.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

class User: Decodable {

    let status: String
    let card_id: String
    let name: String
    let identity: String
    
    init(status: String, card_id: String, name: String, identity: String) {
    
        self.status = status
        self.card_id = card_id
        self.name = name
        self.identity = identity
    }
}
