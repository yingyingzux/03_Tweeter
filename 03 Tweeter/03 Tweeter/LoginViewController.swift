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
        
        TwitterClient.sharedInstance?.login(success: {
            // segue to the next view controller
            print("I've logged in!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, failure: { (error: Error) in
            print("error: \(error.localizedDescription)")
        })
    }

}
