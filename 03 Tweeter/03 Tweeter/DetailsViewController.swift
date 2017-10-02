//
//  DetailsViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/30/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var tweet: Tweet!
    
    var isFaved: Bool = false
    var isRetweeted: Bool = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var retweetAuthorIndicatorImageView: UIImageView!
    @IBOutlet weak var retweetAuthorNameLabel: UILabel!
    
    @IBOutlet weak var tweetAuthorNameLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tweet?.profileImageViewUrl != nil {
            profileImageView.setImageWith((tweet?.profileImageViewUrl!)!)
        } else {
            profileImageView.image = UIImage(named:"bizimage-small.png")
        }
        
        if tweet?.retweetAuthorName != nil {
            retweetAuthorIndicatorImageView.isHidden = false
            retweetAuthorNameLabel.isHidden = false
            
            retweetAuthorNameLabel.text = "\((tweet?.retweetAuthorName)!) Retweeted"
        } else {
            //need to adjust height & gap
            
            retweetAuthorIndicatorImageView.isHidden = true
            retweetAuthorNameLabel.isHidden = true
        }
        
        tweetAuthorNameLabel.text = tweet?.tweetAuthorName
        tweetHandleLabel.text = "@\(tweet?.tweetHandle ?? "")"
        timestampLabel.text = "\((tweet?.timestamp)!)"
        
        //replyButton =
        //retweetButton =
        retweetCountLabel.text = "\(tweet?.retweetCount ?? 0)"
        //favButton
        favCountLabel.text = "\(tweet?.favoritesCount ?? 0)"
        
        textLabel.text = tweet?.text
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView?.layer.cornerRadius = 3
        profileImageView?.clipsToBounds = true
    }
    
    @IBAction func onFavButton(_ sender: Any) {
        //print("default fav count: \(self.tweet.favoritesCount)")
        
        if self.isFaved == false {
        
            TwitterClient.sharedInstance?.favTweet(id: tweet.id, success: { (tweet: Tweet) in
                
                self.tweet = tweet
                self.favButton.setImage(UIImage(named:"faved.png"), for: .normal)
                self.favCountLabel.text = "\(tweet.favoritesCount)"
                //print("Faved! count: \(self.tweet.favoritesCount)")
                self.isFaved = true
                
            }, failure: { (error: Error) in
                print(error)
            })
        } else if self.isFaved == true {
            TwitterClient.sharedInstance?.unFavTweet(id: tweet.id, success: { (tweet: Tweet) in
                
                self.tweet = tweet
                self.favButton.setImage(UIImage(named:"fav.png"), for: .normal)
                self.favCountLabel.text = "\(tweet.favoritesCount)"
                //print("Unfaved! fav count: \(self.tweet.favoritesCount)")
                self.isFaved = false
                
            }, failure: { (error: Error) in
                print(error)
            })
    
        }
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        print("default retweet count: \(self.tweet.retweetCount)")
        
        if self.isRetweeted == false {
            
            TwitterClient.sharedInstance?.retweet(id: tweet.id, success: { (tweet: Tweet) in
                
                self.tweet = tweet
                self.retweetButton.setImage(UIImage(named:"retweeted.png"), for: .normal)
                self.retweetCountLabel.text = "\(tweet.retweetCount)"
                print("Retweeted! count: \(self.tweet.retweetCount)")
                self.isFaved = true
                
            }, failure: { (error: Error) in
                //print("tweet.id:\(self.tweet.id)")
                //print("error in retweet func")
                print(error)
            })
        } else if self.isRetweeted == true {
            
            TwitterClient.sharedInstance?.unRetweet(id: tweet.id, success: { (tweet: Tweet) in
                
                self.tweet = tweet
                self.retweetButton.setImage(UIImage(named:"retweet.png"), for: .normal)
                self.retweetCountLabel.text = "\(tweet.retweetCount)"
                //print("Unfaved! fav count: \(self.tweet.favoritesCount)")
                self.isFaved = false
                
            }, failure: { (error: Error) in
                print(error)
            })
            
        }
    }
    
}
