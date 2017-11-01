//
//  RestaurantInfoTableViewCell.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/3.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class RestaurantInfoTableViewCell: UITableViewCell {

    @IBOutlet var fieldLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
