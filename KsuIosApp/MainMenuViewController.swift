//
//  MainMenuViewController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/9/7.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit
import PKHUD

class MainMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let pictures = ["KS_0", "ksu", "ksu"]
    let schoolPics = ["KsuLogoOne", "ksu", "ksu", "ksu", "ksu", "ksu"]
    let labelArr = ["學生餐廳", "其他", "其他"]
    let labelArr2 = ["特約商店", "其他", "其他"]
    let labelArr3 = ["學校首頁", "KSU-IR", "MyKSU", "網路大學", "成績查詢", "圖書資訊"]
    let headers = ["餐廳服務", "合作廠商", "學校網頁"]
    
//    @IBAction func showRestaurantService(_ sender: Any) {
//        performSegue(withIdentifier: "showRestaurantService", sender: self)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Collection Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return labelArr.count
        case 1:
            return labelArr2.count
        case 2:
            return labelArr3.count
        default:
            return 0
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainMenuCell
            cell.cellImageView.image = UIImage(named: pictures[indexPath.row])
            cell.nameLabel.text = labelArr[indexPath.row]
            
            return cell
            
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainMenuCell
            
            cell.cellImageView.image = UIImage(named: "ksu")
            cell.nameLabel.text = labelArr2[indexPath.row]
            
            return cell
            
        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainMenuCell
            
            cell.cellImageView.image = UIImage(named: schoolPics[indexPath.row])
            cell.nameLabel.text = labelArr3[indexPath.row]
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0:
                let restaurantStoryboard = UIStoryboard(name: "RestaurantService", bundle: nil)
                
                let restaurantService = restaurantStoryboard.instantiateViewController(withIdentifier: "RDetailViewController") as! RDetailViewController
                navigationController?.pushViewController(restaurantService, animated: true)
                
                PKHUD.sharedHUD.hide()
                
            default:
                break
            }
        case 1:
            
            switch indexPath.row {
            case 0:
                
                let urlString: String = "http://120.114.51.180:28080/cr/public/application/ksulife/store"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr2[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            default:
                break
            }
            
        case 2:
            
            switch indexPath.row {
            
            case 0:
                let urlString: String = "http://www.ksu.edu.tw"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr3[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            case 1:
                let urlString: String = "http://cca.ksu.edu.tw/cca/public/auth/index"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr3[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            case 2:
                let urlString: String = "http://my.ksu.edu.tw"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr3[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            case 3:
                let urlString: String = "http://elearning.ksu.edu.tw"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr3[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            case 4:
                let urlString: String = "http://120.114.51.133/ScoreQuery/QueryScore.aspx"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr3[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            case 5:
                let urlString: String = "http://ksu.ebook.hyread.com.tw/index.jsp"
                let webviewStoryboard = UIStoryboard(name: "WebView", bundle: nil)
                let webView = webviewStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                navigationController?.pushViewController(webView, animated: true)
                webView.urlString = urlString
                webView.title = labelArr3[indexPath.row]
                
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { progress in
                    
                }
                
            default:
                break
            }
            
            
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! HeaderCRV
            header.headerLabel.text = headers[indexPath.section]
            
            return header
        default:
            assert(false, "Unexpected element kind")
        }
    }

}
