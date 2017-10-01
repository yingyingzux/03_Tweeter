//
//  TweetsViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/29/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        // refresh control
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        // refresh control - end
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell

        let tweet = tweets?[indexPath.row]
        
        if tweet?.profileImageViewUrl != nil {
            cell.profileImageView.setImageWith((tweet?.profileImageViewUrl!)!)
        } else {
            cell.profileImageView.image = UIImage(named:"bizimage-small.png")
        }
    
        
        if tweet?.retweetAuthorName != nil {
            cell.retweetAuthorIndicatorImageView.isHidden = false
            cell.retweetAuthorNameLabel.isHidden = false
            
            cell.retweetAuthorNameLabel.text = "\((tweet?.retweetAuthorName)!) Retweeted"
        } else {
            //need to adjust height & gap
            //let screenSize: CGRect = UIScreen.main.bounds
            
            cell.retweetAuthorIndicatorImageView.isHidden = true
            cell.retweetAuthorNameLabel.isHidden = true
        }
        
        
        cell.tweetAuthorNameLabel.text = tweet?.tweetAuthorName
        cell.tweetHandleLabel.text = "@\(tweet?.tweetHandle ?? "")"
        cell.timestampLabel.text = "\(tweet?.timestamp)"
        
        //replyButton =
        //retweetButton =
        cell.retweetCountLabel.text = "\(tweet?.retweetCount ?? 0)"
        //favButton
        cell.favCountLabel.text = "\(tweet?.favoritesCount ?? 0)"
        
        cell.TweetTextLabel.text = tweet?.text
        
        cell.selectionStyle = .none // get rid of gray selection
        
        return cell
    }
 
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeTimelineToNewTweetSegue" {
            let navigationController = segue.destination as! UINavigationController
            let newTweetViewController = navigationController.topViewController as! NewTweetViewController
            
        }
        else if segue.identifier == "HomeTimelineToDetailsSegue" {
            let detailsViewController = segue.destination as! DetailsViewController
            
            let tableCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tableCell)
            let tweet = tweets![indexPath!.row]
            detailsViewController.tweet = tweet
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }

}
