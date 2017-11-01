//
//  OrderDetailCell2.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/16.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class OrderDetailCell2: UITableViewCell {

    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var uniPriceLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
