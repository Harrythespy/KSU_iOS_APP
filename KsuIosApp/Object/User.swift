//
//  User.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/14.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

class User: Decodable {

    let status: String
    let ksuId: String
    let studentId: String
    let name: String
    let identity: String
    
    init(status: String, ksuId: String, studentId: String, name: String, identity: String) {
    
        self.status = status
        self.ksuId = ksuId
        self.studentId = studentId
        self.name = name
        self.identity = identity
    }
}
