//
//  MentionsViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 10/5/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MentionsViewController loaded")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.mentionsTimeline(success: { (tweets: [Tweet]) in
            print("Twitter mentions timeline triggered")
            
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        /* refresh control */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentionCell", for: indexPath) as! MentionCell
        
        let tweet = tweets?[indexPath.row]
        
        if tweet?.profileImageViewUrl != nil {
            cell.profileImageView.setImageWith((tweet?.profileImageViewUrl!)!)
        } else {
            cell.profileImageView.image = UIImage(named:"bizimage-small.png")
        }

        cell.nameLabel.text = tweet?.tweetAuthorName
        cell.usernameLabel.text = "@\(tweet?.tweetHandle ?? "")"
        cell.timestampLabel.text = "\((tweet?.timestamp)!)"
        
        cell.retweetCountLabel.text = "\(tweet?.retweetCount ?? 0)"
        
        cell.favCountLabel.text = "\(tweet?.favoritesCount ?? 0)"
        
        cell.tweetTextLabel.text = tweet?.text
        
        cell.selectionStyle = .none // get rid of gray selection
        
        return cell
    }

}
