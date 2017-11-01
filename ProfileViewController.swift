//
//  ProfileViewController.swift
//  
//
//  Created by Harry Shen on 2017/9/13.
//
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(75 ,0 ,0 , 0)
        //self.edgesForExtendedLayout = []
        
        //改變表格視圖背景顏色
        tableView.backgroundColor = UIColor(colorLiteralRed: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        //變更內容列分隔線顏色
        tableView.separatorColor = UIColor(colorLiteralRed: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
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
            cell.valueLabel.text = "沈伯穎"
        case 1:
            cell.fieldLabel.text = "KSUID"
            cell.valueLabel.text = "S103000365"
        case 2:
            cell.fieldLabel.text = "身份"
            cell.valueLabel.text = "學生"
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
