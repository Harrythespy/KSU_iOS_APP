//
//  ProfileViewController.swift
//  
//
//  Created by Harry Shen on 2017/9/13.
//
//

import UIKit
import SDWebImage

class ProfileViewController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var selfImageView: UIImageView!
    
    //宣告使用者預設的方法
    let defaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.contentInset = UIEdgeInsetsMake(75 ,0 ,0 , 0)
        //self.edgesForExtendedLayout = []
        
        //改變表格視圖背景顏色
        tableView.backgroundColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        //變更內容列分隔線顏色
        tableView.separatorColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        //設定 Cell 估算的列高
        //tableView.estimatedRowHeight = 36.0
        //將rowHeight屬性改為ios預設列高
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        self.selfImageView.sd_setImage(with: URL(string: "http://120.114.101.129/Swift/img/pig.jpg"), placeholderImage: UIImage(named: "placeholder"))
    }
    
    @IBAction func logout(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        self.defaults.removeObject(forKey: "username")
        self.defaults.removeObject(forKey: "ksuid")
        self.defaults.removeObject(forKey: "identity")
        
        if (self.defaults.string(forKey: "ksuid") == nil) {
            print("You've logged out.")
        }
        
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfileTableViewCell
        
        //設定Cell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "姓名"
            
            if let username: String = defaults.string(forKey: "username") {
                cell.valueLabel.text = username
                print(username)
            }
            
        case 1:
            cell.fieldLabel.text = "KSUID"
            
            if let ksuid: String = defaults.string(forKey: "ksuid") {
                cell.valueLabel.text = ksuid
                print(ksuid)
            }
            
        case 2:
            cell.fieldLabel.text = "身份"
            if let identity = defaults.string(forKey: "identity") {
                cell.valueLabel.text = identity
                print(identity)
            }
            
        case 3:
            cell.fieldLabel.text = "預設"
            cell.valueLabel.text = "預設"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        
        return cell
    }
    
}
