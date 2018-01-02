//
//  AppDelegate.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/7/6.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import PKHUD
import Reachability
import SDWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        
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
        
        
        //監聽網路狀態
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
                print("連線中")
            }
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                print("未連線")
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        }
        catch {
            print("Could not start Notifier")
        }
        
        return true
    }
    
    @objc func internetChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .none {
            if reachability.connection == .wifi {
                DispatchQueue.main.async {
                    print("透過WIFI連線")
                }
            }
            else {
                DispatchQueue.main.async {
                    print("透過行動網路連線")
                }
            }
        }
        else {
            DispatchQueue.main.async {
                print("沒有連線")
//                let alert = UIAlertController(title: "", message: "你已經斷線了", preferredStyle: .alert)
//                let alertAction = UIAlertAction()
//                alert.addAction(alertAction)
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

