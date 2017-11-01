//
//  User.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/14.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

class User: Codable {
    let id: String
    let ksuid: String
    let password: String
    let name: String
    let identity: String
    
    init(id: String, ksuid: String, password: String, name: String, identity: String) {
        self.id = id
        self.ksuid = ksuid
        self.password = password
        self.name = name
        self.identity = identity
    }
    /*
     init(json:[String: Any]) {
     id = json["id"] as? Int ?? -1
     ksuid = json["ksuid"] as? String ?? ""
     pwd = json["password"] as? String ?? ""
     name = json["name"] as? String ?? ""
     identity = json["identity"] as? String ?? ""
     }
     */
}
