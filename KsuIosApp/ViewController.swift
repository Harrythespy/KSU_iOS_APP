//
//  ViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/7/6.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
import PKHUD
import Reachability

class ViewController: UIViewController {
    
    @IBOutlet weak var ksuid: UITextField!
    @IBOutlet weak var pwd: UITextField!

    private var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ksuid.text = "harry"
        pwd.text = "AAA"
        
        /******** PKHUD SDK *********/
        //HUD.flash(.success, delay: 1.0)
        /*
         HUD.flash(.success, delay: 1.0) { finished in
             //Completion Handler
         }
        */
        /*
         PKHUD.sharedHUD.contentView = PKHUDSuccessView()
         PKHUD.sharedHUD.show()
         PKHUD.sharedHUD.hide(afterDelay: 1.0) { success in
            // Completion Handler
         }
         */
        /*
         HUD.show(.progress)
         
         // Now some long running task starts...
         delay(2.0) {
         // ...and once it finishes we flash the HUD for a second.
         HUD.flash(.success, delay: 1.0)
         }
         */
        /*******************************/
        
        //改變狀態列顏色
        //UIApplication.shared.statusBarStyle = .default
        
        ksuid.clearButtonMode = .whileEditing
        pwd.clearButtonMode = .whileEditing
        pwd.isSecureTextEntry = true
        
        //避免鍵盤擋住文字輸入框
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //解析json
        ParseJson()
        
        
    }
    
    //MARK: - 避免鍵盤擋住文字輸入框
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let duration: Double = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
            
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.view.frame
                frame.origin.y = keyboardFrame.minY - self.view.frame.height
                self.view.frame = frame
            })
        }
    }
    
    //MARK: - Json Parse
    
    func ParseJson() {
        
        let jsonUrlString = "http://120.114.101.129/Swift/user.php"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            //let dataAsString = String(data: data,encoding: .utf8)
            
            do {
                let userResults = try JSONDecoder().decode(Array<User>.self, from: data)
                
                for user in userResults {
                    //let eachUser = user as! [String: Any]
                    let id = user.id
                    let ksuid = user.ksuid
                    let password = user.password
                    let name = user.name
                    let identity = user.identity
                    
                    self.users.append(User(id: id, ksuid: ksuid, password: password, name: name, identity: identity))
                    print(ksuid)
                    print(password)
                }
                
            }catch let jsonErr {
                print("Error Serializing Json:", jsonErr)
            }
            
        }.resume()
    }
    
    
    @IBAction func login(_ sender: Any) {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        if (ksuid.text == "" || pwd.text == "") {
            print("請輸入帳號密碼")
            let alert = UIAlertController.init(title: "尚未輸入", message: "帳號或密碼尚未輸入請重新填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            ksuid.text = ""
            pwd.text = ""
            return
        }
        else if (ksuid.text == "harry" && pwd.text == "AAA") {
            //宣告NavigationController
            let navigationController = storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
            //宣告indexViewController 為 NavigationController 的第一頁
            //let indexViewController = navigationController.viewControllers.first as! IndexViewController
            
            present(navigationController, animated: true, completion: nil)
            PKHUD.sharedHUD.hide()
        }
        else {
            print("帳號密碼不正確")
            let alert = UIAlertController.init(title: "帳號密碼不正確", message: "帳號或密碼不正確請重新填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            ksuid.text = ""
            pwd.text = ""
        }
        
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /** //presses return key//
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     ksuid.resignFirstResponder()
     pwd.resignFirstResponder()
     return (true)
     }
     **/
}


