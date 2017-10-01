//
//  TweetCell.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/30/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var retweetAuthorIndicatorImageView: UIImageView!
    
    @IBOutlet weak var retweetAuthorNameLabel: UILabel!
    
    @IBOutlet weak var tweetAuthorNameLabel: UILabel!
    
    @IBOutlet weak var tweetHandleLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var TweetTextLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var replyCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var favCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
