//
//  CartCell.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/11/8.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteMeal(_ sender: Any) {
//        let alert = UIAlertController(title: "", message: "已刪除該選項", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(alertAction)
    }
    
}
