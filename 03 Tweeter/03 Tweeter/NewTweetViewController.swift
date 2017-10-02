//
//  NewTweetViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/30/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    var user: User!
    var tweet: Tweet!
    
    //var DataManager: DataManager
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetAuthorNameLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var newTweetTextView: UITextView!
    @IBOutlet weak var newTweetTextLimitCounterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTweetTextView.delegate = self
        
        let user = User.currentUser
        
        if user!.profileUrl != nil {
            profileImageView.setImageWith((user?.profileUrl!)!)
        } else {
            profileImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        tweetAuthorNameLabel.text = user!.name
        tweetHandleLabel.text = "@\(user!.screenname ?? "missing_handle")"
        
        
        //newTweetTextView.text = ""
        //newTweetTextView.textColor = UIColor.lightGray
        
        newTweetTextView.becomeFirstResponder()
    }

    @IBAction func onTweetButton(_ sender: Any) {
        TwitterClient.sharedInstance?.postNewTweet(text: newTweetTextView.text)
        //DataManager.firstVC.tableView.reloadData()
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView?.layer.cornerRadius = 3
        profileImageView?.clipsToBounds = true
    }
    
    @objc(textView:shouldChangeTextInRange:replacementText:) func textView (_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the textView text and the replacement text to
        // create the updated text string
        if range.length + range.location > newTweetTextView.text.characters.count {
            return false
        }
        
        let newLength = newTweetTextView.text.characters.count + text.characters.count - range.length
        newTweetTextLimitCounterLabel.text = "\(140 - newLength)"
        
        return newLength <= 140
        
        }
}
