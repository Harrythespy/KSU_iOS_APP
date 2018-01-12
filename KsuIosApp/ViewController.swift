//
//  ViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/7/6.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: BaseController {
    
    
    @IBOutlet weak var ksuid: UITextField! //UI的ksuid輸入框
    @IBOutlet weak var pwd: UITextField! //UI的密碼輸入框
    
    let m = M() //宣告自訂函式類別
    let urlString = "http://120.114.101.129/Swift/user.php" //使用者ＡＰＩ網址
    
    var user = [User]()
    var status = ""
    var card_id = ""
    var name = ""
    var identity = ""
    
    //儲存帳密
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //改變狀態列顏色
        UIApplication.shared.statusBarStyle = .default
        
        //使用輸入框時出現刪除按鈕
        ksuid.clearButtonMode = .whileEditing
        pwd.clearButtonMode = .whileEditing
        //密碼輸入框設定為密碼格式
        pwd.isSecureTextEntry = true
        
        self.defaults.removeObject(forKey: "cartList")
        
        ksuid.text = "S103000365"
        pwd.text = "bbb"
    }
    
    //MARK: - POST Data 將資料GET到SERVER
    
    func postData() {
        
        guard let url = URL(string: self.urlString) else { return }
        
        let request = NSMutableURLRequest(url: url) //SERVER位址
        request.httpMethod = "POST" //使用POST方法傳遞資料到SERVER
        
        let postString = "acc=\(ksuid.text!)&pas=\(pwd.text!)" //將兩個輸入框的值儲存為字串
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
                    let userJson = try JSONDecoder().decode(User.self, from: data!) //json解析方法
                    
                    self.status = userJson.status
                    self.card_id = userJson.card_id
                    self.name = userJson.name
                    self.identity = userJson.identity
                    
                }catch let jsonErr {
                    print("Error Serializing Json:", jsonErr)
                }
            }
            //控制UI執行緒介面的物件
            DispatchQueue.main.async {
                self.tryLogin() //呼叫登入判斷的方法
                PKHUD.sharedHUD.hide() //隱藏旋轉動畫
            }
        }
        task.resume()
    }
    
    func tryLogin() {
        //啟動HUD 等待圖示
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        
        //這個區塊是判斷輸入框是否都有輸入
        if (self.ksuid.text == "" || self.pwd.text == "") { //如果輸入框沒有輸入任何值
            PKHUD.sharedHUD.hide() //隱藏旋轉動畫
            m.alertMessage(UIViewController: self, alertTitle: "尚未輸入", alertMessage: "帳號或密碼尚未輸入請重新填寫")
            return
        }
        //這個區塊是判斷帳號或密碼錯誤
        if (self.status.trimmingCharacters(in: .whitespaces) == "false") {
            m.alertMessage(UIViewController: self, alertTitle: "", alertMessage: "帳號或密碼錯誤")
            return
        }
        
        //帳號密碼登入正確
        PKHUD.sharedHUD.show()
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController //宣告NavigationController
        //宣告indexViewController 為 NavigationController 的第一頁
        //let indexViewController = navigationController.viewControllers.first as! IndexViewController
        
        self.present(navigationController, animated: true, completion: nil)
        PKHUD.sharedHUD.hide() //隱藏旋轉動畫
        
        //若能成功登入將儲存帳密資料至userDefaults方法中
        //save persistent data through the lifespan of the app
        
        //儲存使用者的ksuid
        defaults.set(self.ksuid.text, forKey: "ksuid")
        //儲存使用者的名字
        defaults.set(self.name, forKey: "username")
        //儲存使用者的身份
        defaults.set(self.identity, forKey: "identity")
        self.defaults.synchronize()
    }
    
    @IBAction func login(_ sender: Any) { //登入按鈕觸發事件
        PKHUD.sharedHUD.show()
        postData() //POST資料並解析
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


