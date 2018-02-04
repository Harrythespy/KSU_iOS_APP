//
//  SendOrderViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2018/1/11.
//  Copyright © 2018年 Harry Shen. All rights reserved.
//

import UIKit
import PKHUD

struct OrderList: Codable {
    var username: String
    var ksuid: String
    var studentId: String
    var identity: String
    var orderLists: [CartList]
    
    init(username: String, ksuid: String, studentId: String, identity: String, orderLists: [CartList]) {
        self.username = username
        self.ksuid = ksuid
        self.studentId = studentId
        self.identity = identity
        self.orderLists = orderLists
    }
}

class SendOrderViewController: BaseController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let defaults: UserDefaults = UserDefaults.standard
    var jsonString = ""
    var cartList: [CartList] = []
    var orderList: [OrderList] = []
    var username = ""
    var ksuId = ""
    var studentId = ""
    var identity = ""
    
    var price = 0
    var amount = 0
    var orderId = ""
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "訂單確認"
        getUserInfo()
        self.orderList.append(OrderList(username: self.username, ksuid: self.ksuId, studentId: self.studentId, identity: self.identity, orderLists: self.cartList))
        self.jsonString = jsonCoverting(object: self.orderList)
    }
    
    //MARK: - Send Order Button
    
    @IBAction func sendOrder(_ sender: Any) {

        let orderAlert = UIAlertController(title: "按下確認按鈕送出訂單", message: "若點選確認按鈕將會送出本次訂單，送出後則不得進行修改內容，請再送出前進行完整確認\n若訂單不慎填寫錯誤請自行聯絡店家已進行訂單修改\n訂單送出後經由店家審核訂單無誤，店家確認接單後，將會更改訂單的狀態\n若要查看訂單狀態及詳細內容請選擇訂單頁籤以查看歷史訂單記錄", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        orderAlert.addAction(cancelAction)
        let sendAction = UIAlertAction(title: "確認", style: .destructive, handler: {(alert: UIAlertAction!) in

            self.postData()
            self.defaults.removeObject(forKey: "cartList")
            if (self.defaults.string(forKey: "cartList") == nil) {
                print("訂單已送出，清除購物清單.")
            }
        })
        orderAlert.addAction(sendAction)
        present(orderAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - 將字典陣列轉為JSON
    
    func jsonCoverting(object: [OrderList]) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try? encoder.encode(object)
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        print(jsonString)
        return jsonString
    }
    
    //MARK: - POST Data 將資料 GET 到 SERVER
    
    func postData() {
        PKHUD.sharedHUD.show()
        let urlString = "http://120.114.101.129/Swift/getOrderList.php" //接收訂單ＡＰＩ網址
        
        guard let url = URL(string: urlString) else { return }
        
        let request = NSMutableURLRequest(url: url) //SERVER位址
        request.httpMethod = "POST" //使用POST方法傳遞資料到SERVER
        
        let postString = "orderList=\(self.jsonString)" //將訂單陣列儲存為字串
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if (error != nil) {
                print("Error= \(error!)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            else {
                print("response= \(response!)")
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString= \(responseString!)")
                do { //json解析時的拋出事件
                    let userJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: String] //json解析方法
                    self.status = userJson!["status"]!
                    self.orderId = userJson!["order_id"]!
                }
                catch let jsonErr {
                    print("Error Serializing Json:", jsonErr)
                }
            }
            DispatchQueue.main.sync {
                self.orderSentCheck()
            }
        }
        task.resume()
    }
    
    func orderSentCheck() {
        let m = M()
        //訂單送出失敗則跳出警示訊息
        //手機端發生錯誤
        if self.status == "" {
            m.alertMessage(UIViewController: self, alertTitle: "發生錯誤，該訂單無法送出", alertMessage: "請確認網路狀態是否正常，稍後再重新送出")
            return
        }
        //伺服器發生錯誤
        if (self.status.trimmingCharacters(in: .whitespaces) == "error") {
            m.alertMessage(UIViewController: self, alertTitle: "發生錯誤，伺服器異常", alertMessage: "伺服器發生錯誤，請稍待片刻")
            return
        }
        //如果解析出的字串正確轉頁至訂單完成頁面
        let storyboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let orderCompleted = storyboard.instantiateViewController(withIdentifier: "OrderCompletedVC") as! OrderCompletedVC
        self.navigationController?.pushViewController(orderCompleted, animated: true)
        orderCompleted.orderId = self.orderId
        PKHUD.sharedHUD.hide()
        //present(orderCompleted, animated: true, completion: nil)
    }
    
    //MARK: - User Defaults
    
    func getUserInfo() {
        if let ksuId = defaults.string(forKey: "ksuId") {
            self.ksuId = ksuId
        }
        if let studentId = defaults.string(forKey: "studentId") {
            self.studentId = studentId
        }
        if let username = defaults.string(forKey: "username") {
            self.username = username
        }
        if let identity = defaults.string(forKey: "identity") {
            self.identity = identity
        }
    }
    
    //MARK: - Table Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 //因為要回傳固定的表格欄數
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sendOrderCell = self.tableView.dequeueReusableCell(withIdentifier: "SendOrderCell", for: indexPath) as! SendOrderCell
        
        switch indexPath.row {
        case 0:
            sendOrderCell.fieldlabel.text = "取餐人姓名"
            sendOrderCell.valueLabel.text = "\(self.orderList[0].username)" //因為二維的orderlist只會有一筆資料因此固定為0
        case 1:
            sendOrderCell.fieldlabel.text = "KSU ID"
            sendOrderCell.valueLabel.text = "\(self.orderList[0].ksuid)"
        case 2:
            sendOrderCell.fieldlabel.text = "學號"
            sendOrderCell.valueLabel.text = "\(self.orderList[0].studentId)"
        case 3:
            sendOrderCell.fieldlabel.text = "餐點總數量"
            sendOrderCell.valueLabel.text = "\(self.amount) 份"
        case 4:
            sendOrderCell.fieldlabel.text = "總金額"
            sendOrderCell.valueLabel.text = "NT$ \(self.price)"
        case 5:
            sendOrderCell.fieldlabel.text = "備註事項"
            sendOrderCell.valueLabel.text = ""
        default:
            break
        }
        
        self.tableView.rowHeight = 70
        
        return sendOrderCell
    }
}
