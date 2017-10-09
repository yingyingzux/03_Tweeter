//
//  AccountCell.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 10/8/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    
    @IBOutlet weak var accountCellView: UIView!
    @IBOutlet weak var accountCellProfileImageView: UIImageView!
    @IBOutlet weak var accountCellNameLabel: UILabel!
    @IBOutlet weak var accountCellScreenNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
