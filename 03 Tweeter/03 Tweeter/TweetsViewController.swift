//
//  TweetsViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/29/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController/*,  UITableViewDelegate, UITableViewDataSource*/ {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.dataSource = self
        //tableView.delegate = self
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
            
            //self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cell
    }
 */
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }

}
