//
//  AddCartCell3.swift
//  KsuIosApp
//
//  Created by Harry Shen on 2017/10/23.
//  Copyright © 2017年 Harry Shen. All rights reserved.
//

import UIKit

class AddCartCell3: UITableViewCell {

    @IBOutlet var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}
