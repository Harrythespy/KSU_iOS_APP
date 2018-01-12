//
//  SendOrderViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2018/1/11.
//  Copyright © 2018年 Harry Shen. All rights reserved.
//

import UIKit

class SendOrderViewController: UIViewController {

    let defaults: UserDefaults = UserDefaults.standard
    
    var userInfo = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "訂單確認"
        getUserInfo()
        
    }
    
    //MARK: - Send Order Button
    
    @IBAction func sendOrder(_ sender: Any) {
        let orderAlert = UIAlertController(title: "訂單確認", message: "請按下確認按鈕以送出本次的訂單", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        orderAlert.addAction(cancelAction)
        let sendAction = UIAlertAction(title: "確認", style: .destructive, handler: {(alert: UIAlertAction!) in
            print("送出訂單")
        })
        orderAlert.addAction(sendAction)
        
        present(orderAlert, animated: true, completion: nil)
    }
    
    //MARK: - User Defaults
    
    func getUserInfo() {
        if let ksuid = defaults.string(forKey: "ksuid") {
            self.userInfo.updateValue(ksuid, forKey: "ksuid")
        }
        if let username = defaults.string(forKey: "username") {
            self.userInfo.updateValue(username, forKey: "username")
        }
        if let identity = defaults.string(forKey: "identity") {
            self.userInfo.updateValue(identity, forKey: "identity")
        }
        print(self.userInfo)
    }
}
