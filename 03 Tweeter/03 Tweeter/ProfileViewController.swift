//
//  ProfileViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 10/5/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: User!
    var tweets: [Tweet]!
    var idForProfile: Int! = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileAvartarImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileDescriptionLabel: UILabel!
    @IBOutlet weak var profileLocationLabel: UILabel!
    @IBOutlet weak var profileTweetCount: UILabel!
    @IBOutlet weak var profileFollowingCount: UILabel!
    @IBOutlet weak var profileFollowersCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("ProfileViewController loaded")
        
        //print("idForProfile in ProfileViewController view did load: \(idForProfile)")
        if idForProfile == 0 {
            user = User.currentUser
            getCurrentUserInfo()
            
            TwitterClient.sharedInstance?.userTimeline(id: (user?.id)!, success: { (tweets: [Tweet]) in
                
                print("Twitter user timeline triggered")
                
                self.tweets = tweets
                
                self.tableView.reloadData()
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        } else {
            print("idForProfile passed from TweetsViewController")
            user = User.currentUser
            
            TwitterClient.sharedInstance?.userTimeline(id: idForProfile, success: { (tweets: [Tweet]) in
                
                print("Twitter user timeline triggered")
                
                self.tweets = tweets
                
                self.getTweetUserInfo(tweets: self.tweets)
                
                self.tableView.reloadData()
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            
 
        }
 

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        let tweet = tweets?[indexPath.row]
    
        if tweet?.profileImageViewUrl != nil {
            cell.profileCellProfileImageView.setImageWith((tweet?.profileImageViewUrl!)!)
        } else {
            cell.profileCellProfileImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        if tweet?.retweetAuthorName != nil {
            cell.profileCellRetweetAuthorImageViewTopContraint.constant = 12
            cell.profileCellRetweetAuthorImageView.isHidden = false
            cell.profileCellRetweetAuthorNameLabel.isHidden = false
            
            cell.profileCellRetweetAuthorNameLabel.text = "\((tweet?.retweetAuthorName)!) Retweeted"
        } else {
            //need to adjust height & gap
            //let screenSize: CGRect = UIScreen.main.bounds
            cell.profileCellRetweetAuthorImageViewTopContraint.constant = 0
            cell.profileCellRetweetAuthorImageView.isHidden = true
            cell.profileCellRetweetAuthorNameLabel.isHidden = true
        }
        
        cell.profileCellNameLabel.text = tweet?.tweetAuthorName
        cell.profileCellUsernameLabel.text = "@\(tweet?.tweetHandle ?? "")"
        cell.profileCellTimestampLabel.text = "\((tweet?.timestamp)!)"
        
        cell.profileCellRetweetCount.text = "\(tweet?.retweetCount ?? 0)"
        
        cell.profileCellFavCount.text = "\(tweet?.favoritesCount ?? 0)"
        
        cell.profileCellTweetTextLabel.text = tweet?.text
        
        cell.selectionStyle = .none // get rid of gray selection
        
        return cell
    }
    
    func getCurrentUserInfo() {
        if user!.profileUrl != nil {
            profileAvartarImageView.setImageWith((user?.profileUrl!)!)
        } else {
            profileAvartarImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        if user!.profileBackgroundUrl != nil {
            backgroundImageView.setImageWith((user?.profileBackgroundUrl!)!)
        } else {
            backgroundImageView.tintColor = UIColor(red:0.00, green:0.64, blue:0.93, alpha:1.0)
            //backgroundImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        if user!.tagline != nil {
            profileDescriptionLabel.text = user?.tagline
        } else {
            profileDescriptionLabel.text = "No description"
        }
        
        if user!.location != nil {
            profileLocationLabel.text = user?.location
        } else {
            profileLocationLabel.text = "No loation info"
        }
        
        profileNameLabel.text = user!.name
        profileUsernameLabel.text = "@\(user!.screenname ?? "missing_handle")"
        
        profileTweetCount.text = "\(user!.tweetCount ?? 0)"
        profileFollowingCount.text = "\(user!.followingCount ?? 0)"
        profileFollowersCount.text = "\(user!.followersCount ?? 0)"
    }
    
    func getTweetUserInfo(tweets: [Tweet]) {
        let tweet = tweets.first
        
        print("getTweetUserInfo tweet?.userDictionary: \(tweet?.userDictionary)")

        let name = tweet?.userDictionary?["name"]
        let screenname = tweet?.userDictionary?["screen_name"]
        var profileUrl: URL?
        var profileBackgroundUrl: URL?
        let tagline = tweet?.userDictionary?["tagline"]
        let location = tweet?.userDictionary?["location"]
        let tweetCount = tweet?.userDictionary?["statuses_count"]
        let followersCount = tweet?.userDictionary?["followers_count"]
        let followingCount = tweet?.userDictionary?["friends_count"]
        
        let profileUrlString = tweet?.userDictionary?["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString) as! URL
        }
        if profileUrl != nil {
            profileAvartarImageView.setImageWith((profileUrl!))
        } else {
            profileAvartarImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        let profileBackgroundUrlString = tweet?.userDictionary?["profile_background_image_url_https"] as? String
        if let profileBackgroundUrlString = profileBackgroundUrlString {
            profileBackgroundUrl = NSURL(string: profileBackgroundUrlString) as! URL
        }
        if profileBackgroundUrl != nil {
            backgroundImageView.setImageWith((profileBackgroundUrl!))
        } else {
            backgroundImageView.tintColor = UIColor(red:0.00, green:0.64, blue:0.93, alpha:1.0)
            //backgroundImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        if tagline != nil {
            profileDescriptionLabel.text = tagline as! String
        } else {
            profileDescriptionLabel.text = "No description"
        }
        
        if location != nil {
            profileLocationLabel.text = location as! String
        } else {
            profileLocationLabel.text = "No loation info"
        }
        
        profileNameLabel.text = name as! String
        profileUsernameLabel.text = "@\(screenname ?? "missing_handle")"
        
        profileTweetCount.text = "\(tweetCount ?? 0)"
        profileFollowingCount.text = "\(followingCount ?? 0)"
        profileFollowersCount.text = "\(followersCount ?? 0)"
    }
    
}
