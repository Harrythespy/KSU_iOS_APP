//
//  OrderDetailTableViewCell.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/6.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet var idLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
