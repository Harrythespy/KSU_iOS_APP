//
//  M.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/11/18.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//
import UIKit

class M {
    
    
    //彈跳視窗方法
    func alertMessage(UIViewController: UIViewController,alertTitle: String, alertMessage: String) -> Void {
        let alert = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好", style: .cancel, handler: nil))
        UIViewController.present(alert, animated: true, completion: nil)
    }
}
