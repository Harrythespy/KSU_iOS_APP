//
//  QRCodeController.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/10.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class QRCodeController: UIViewController {

    @IBOutlet var qrcodeImageView: UIImageView!
    @IBOutlet var mealLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    var order: Order!
    var labelString: String = ""
    var labelString2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "QR Code 取餐"
        
        mealLabel.text = labelString
        labelString2 = "等，共 \(order.order_detail.count) 個餐點"
        amountLabel.text = labelString2
        
        generateQrCode()
        
    }
    
    //字串生成QRCODE
    func generateQrcodeFromString(string: String) -> UIImage? {
        //
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")

        filter?.setValue(data, forKey: "inputMessage")
        //        let transform = CGAffineTransform.init(scaleX: 10, y: 10)
        let transform = CGAffineTransform.init(scaleX: 10, y: 10)

        let output = filter?.outputImage?.transformed(by: transform)
        if (output != nil) {
            
            return UIImage(ciImage: output!)
            
        }
        
        return nil
    }

    func generateQrCode() {

        qrcodeImageView.image = generateQrcodeFromString(string: order.order_id)

    }

}
