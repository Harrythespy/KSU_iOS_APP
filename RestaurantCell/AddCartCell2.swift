//
//  addCartCell2.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/20.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class AddCartCell2: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func amountStepper(_ sender: UIStepper) {
        let value = stepper.value
        amountLabel.text = String(Int(value))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amountLabel.text = "1"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
