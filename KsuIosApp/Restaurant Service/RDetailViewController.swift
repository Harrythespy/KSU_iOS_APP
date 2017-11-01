//
//  RDetailViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/7/14.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class RDetailViewController: UIViewController {

    var restuarant: Restaurant!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var menuView: UIView!
    @IBOutlet var orderView: UIView!
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            menuView.isHidden = false
            orderView.isHidden = true
            
        case 1:
            menuView.isHidden = true
            orderView.isHidden = false
            
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.isHidden = false
        orderView.isHidden = true
        
        //移除返回按鈕的標題
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func displayCart(sender: AnyObject) {
        let shoppingCart = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let cart = shoppingCart.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(cart, animated: true)
    }
}
