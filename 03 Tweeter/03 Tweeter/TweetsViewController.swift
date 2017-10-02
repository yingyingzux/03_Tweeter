//
//  TweetsViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/29/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    
    var tweets: [Tweet]!
    var newTweet: Tweet!
    
    var isFaved: [Bool] = [false]

    
    @IBOutlet weak var tableView: UITableView!
    
    var isMoreDataLoading = false // Inifinite scroll
    var loadingMoreView:InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("TwitterViewController view loaded")
        //NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: newTweet)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // Infinite scroll - start
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        // Infinite scroll - end
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            
            print("Twitter general hometimeline triggered")
            self.tweets = tweets
            
            if self.newTweet != nil {
                self.tweets.append(self.newTweet)
            } else {
                print("newTweets is nil")
            }
            
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
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
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
        cell.timestampLabel.text = "\((tweet?.timestamp)!)"
        
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
            
            //newTweetViewController.DataManager = DataManager()
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
    
    @IBAction func onFavButton(_ sender: Any) {
      
        let section = 0
        let row = (sender as AnyObject).tag
        let indexPath = IndexPath(row: row!, section: section)
        let cell: TweetCell = tableView.cellForRow(at: indexPath) as! TweetCell
        
        var tweetToFavOrUnFav = tweets![indexPath.row]
        
        //print("default fav count: \(tweetToFavOrUnFav.favoritesCount)")
        
         if self.isFaved[indexPath.row] == false {
         
            TwitterClient.sharedInstance?.favTweet(id: tweetToFavOrUnFav.id, success: { (tweet: Tweet) in
                
                tweetToFavOrUnFav = tweet
                
                cell.favButton.setImage(UIImage(named:"faved.png"), for: .normal)
                cell.favCountLabel.text = "\(tweetToFavOrUnFav.favoritesCount)"
                cell.favCountLabel.textColor = UIColor(red:0.87, green:0.16, blue:0.38, alpha:1.0)
                
                //print("Faved! count: \(tweetToFavOrUnFav.favoritesCount)")
                self.isFaved[indexPath.row] = true
                
            }, failure: { (error: Error) in
                print(error)
            })
         } else if self.isFaved[indexPath.row] == true {
            TwitterClient.sharedInstance?.unFavTweet(id: tweetToFavOrUnFav.id, success: { (tweet: Tweet) in
                
                tweetToFavOrUnFav = tweet
                cell.favButton.setImage(UIImage(named:"fav.png"), for: .normal)
                cell.favCountLabel.text = "\(tweetToFavOrUnFav.favoritesCount)"
                cell.favCountLabel.textColor = UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0)
                //print("Unfaved! fav count: \(tweetToFavOrUnFav.favoritesCount)")
                self.isFaved[indexPath.row] = false
                
            }, failure: { (error: Error) in
                print(error)
            })

         }


    }
    
    
    func loadList(){
        //load data here
        print("loadList is triggered")
        self.tableView.reloadData()
    }
    
    // Inifite scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                    // Update position of loadingMoreView, and start loading indicator
                    let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                
                    print("loadingMoreView: \(loadingMoreView)")
                    print("isMoreDataLoading: \(isMoreDataLoading)")
                
                    loadingMoreView?.frame = frame
                    loadingMoreView?.startAnimating()
                
                    // ... Code to load more results ...
                
                
                    TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
                    
                        self.tweets = tweets
                        
                        self.tableView.reloadData()
                        self.isMoreDataLoading = false
                        
                    }, failure: { (error: Error) in
                        print(error.localizedDescription)
                    })
                
                
                
                }
                
            }
        }
}

class InfiniteScrollActivityView: UIView {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.isHidden = true
    }
    
    func startAnimating() {
        self.isHidden = false
        self.activityIndicatorView.startAnimating()
    }
}

