//
//  LoginViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/27/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "c6swN7N237KLpzIPZcSpaUjBm", consumerSecret: "PKN22t0T4XnBDhoT54N5mKdF0GMDcogsItko5mp3IrAx5qOEwm")
        
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytweeter://oauth")! as URL, scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            //print("I got a token!")
            
            let url = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
            UIApplication.shared.openURL(url as URL)
            
        }) { (error: Error!) -> Void in
                print("error: \(error.localizedDescription)")
        }
    }

}
