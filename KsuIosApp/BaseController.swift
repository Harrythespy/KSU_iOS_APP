//
//  BaseController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2018/1/6.
//  Copyright © 2018年 Harry Shen. All rights reserved.
//
import UIKit
import Reachability
import SwiftMessages

class BaseController: UIViewController {
    
    let reachability = Reachability()!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /*********** 網路狀態的UI畫面 **************/
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        //config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        config.dimMode = .gray(interactive: false)
        
        let connectView = MessageView.viewFromNib(layout: .statusLine)
        connectView.bodyLabel?.text = "Disconnect the Internet.  請重新檢查您的網路狀態"
        
        
        //監聽網路狀態
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                //print("連線中")
                SwiftMessages.hide()
            }
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                //print("未連線")
                SwiftMessages.show(config: config, view: connectView)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        }
        catch {
            print("Could not start Notifier")
        }
        /*********** 網路狀態的UI畫面 **************/
        
        /*********** 狀態列 **************/
        
        //取得導覽列類別的外觀代理 UINavigationBar.appearance()
        //更改導覽列背景顏色
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 6/255.0, green: 136.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        //更改導覽列標題樣式
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:barFont]
        }
        //更改導覽列按鈕項目顏色
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //改變狀態列顏色
        UIApplication.shared.statusBarStyle = .lightContent
        
        /*********** 狀態列 **************/
    }
    
    @objc func internetChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .none {
            if reachability.connection == .wifi {
                DispatchQueue.main.async {
                    //print("透過WIFI連線")
                }
            }
            else {
                DispatchQueue.main.async {
                    //print("透過行動網路連線")
                }
            }
        }
        else {
            DispatchQueue.main.async {
                //print("沒有連線")
            }
        }
    }
    
}
