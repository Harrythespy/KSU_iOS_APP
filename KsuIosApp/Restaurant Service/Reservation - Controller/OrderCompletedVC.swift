//
//  OrderCompletedVC.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2018/1/22.
//  Copyright © 2018年 Harry Shen. All rights reserved.
//

import UIKit
import PKHUD

class OrderCompletedVC: BaseController {

    @IBOutlet weak var orderIdLabel: UILabel!
    var orderId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderIdLabel.text = "No. \(orderId)"
        title = "成功頁面"
        navigationItem.hidesBackButton = true
        HUD.flash(.success, delay: 15.0)
    }
    
    
    
}
