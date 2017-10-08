//
//  ProfileCell.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 10/7/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    
    @IBOutlet weak var profileCellProfileImageView: UIImageView!
    
    @IBOutlet weak var profileCellRetweetAuthorImageViewTopContraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileCellRetweetAuthorImageView: UIImageView!
    
    @IBOutlet weak var profileCellRetweetAuthorNameLabel: UILabel!
    
    @IBOutlet weak var profileCellNameLabel: UILabel!
    @IBOutlet weak var profileCellUsernameLabel: UILabel!
    @IBOutlet weak var profileCellTweetTextLabel: UILabel!
    
    @IBOutlet weak var profileCellTimestampLabel: UILabel!
    @IBOutlet weak var profileCellRetweetCount: UILabel!
    @IBOutlet weak var profileCellFavCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
