//
//  OrderDetailViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/9/29.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var order: Order!
    var totalPrice: Int = 0
    var totalAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //移除返回按鈕的標題
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
        
        title = "訂單明細"
        
        print(order.ksuid)
        
    }
    
    
    // section表頭文字
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 1:
            return "訂單明細表"
        case 2:
            return "訂單內容"
        default:
            return ""
        }
        
    }
    
    //section中的筆數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return order.order_detail.count
        default:
            return 0
        }
        
    }
    
    //section的筆數
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        totalPrice = 0
        totalAmount = 0
        
        for order in order.order_detail {
            totalPrice += Int(order.amount)! * Int(order.price)!
            totalAmount += Int(order.amount)!
        }
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailCell
            
            //設定Cell
            switch indexPath.row {
            case 0:
                cell.fieldLabel.text = "訂單編號"
                cell.valueLabel.text = "No. \(order.order_id)"
            case 1:
                cell.fieldLabel.text = "訂單狀態"
                cell.valueLabel.text = order.status
            case 2:
                cell.fieldLabel.text = "訂單時間"
                cell.valueLabel.text = order.order_time
            case 3:
                cell.fieldLabel.text = "訂餐人"
                cell.valueLabel.text = order.ksuid
            default:
                cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
            }
            
            cell.backgroundColor = UIColor.clear
            self.tableView.rowHeight = 60
            //cell選擇特效
            cell.selectionStyle = .none
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailCell
            
            //設定訂單明細cell
            switch indexPath.row {
                
            case 0:
                cell.fieldLabel.text = "總金額"
                cell.valueLabel.text = "NT$ \(String(totalPrice))"
            case 1:
                cell.fieldLabel.text = "訂購數量"
                cell.valueLabel.text = "X \(totalAmount)"
            case 2:
                cell.fieldLabel.text = "訂購金額"
                cell.valueLabel.text = "NT$ \(String(totalPrice))"
            default:
                cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
            }
            
            cell.backgroundColor = UIColor.clear
            self.tableView.rowHeight = 60
            //cell選擇特效
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! OrderDetailCell2
            
            let orderDetail = order.order_detail[indexPath.row]
            let amount = (Int(orderDetail.amount))!
            let price = (Int(orderDetail.price))!
            let total = (amount * price)
            
            cell2.mealNameLabel.text = orderDetail.meal_name
            cell2.amountLabel.text = "數量Ｘ\(orderDetail.amount)"
            cell2.uniPriceLabel.text = "單價 NT$ \(orderDetail.price)"
            cell2.priceLabel.text = "小計 NT$ \(String(total))"
            
            cell2.backgroundColor = UIColor.clear
            self.tableView.rowHeight = 120
            //cell選擇特效
            cell2.selectionStyle = .none
            
            return cell2
            
        default:
            return UITableViewCell()
        }
        
    }

    
    @IBAction func showQRCode(_ sender: Any) {
        print("showQRCode wtih orderId:",order.order_id)
        
        let qrCode = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeController") as! QRCodeController
        navigationController?.pushViewController(qrCode, animated: true)
        qrCode.labelString = order.order_detail[0].meal_name
        qrCode.order = self.order as Order
    }
    
    //MARK: - Segue
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showQRCode" {
//            
//            let destinationController = segue.destination as! QRCodeController
//            
//            destinationController.order = order
//        }
//    }

}
