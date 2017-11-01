//
//  ReservationViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/7/26.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String = ""
    var webTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        if webView != nil {
            webView.load(request)
        }else {
            print("web is nil")
        }
        
        navigationController?.title = self.webTitle
        
        // Do any additional setup after loading the view.
    }
}
