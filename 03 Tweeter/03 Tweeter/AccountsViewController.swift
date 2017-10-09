//
//  AccountsViewController.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 10/5/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // tableView outlet
    @IBOutlet var tableView: UITableView!
    
    var user: User!
    var users: [User]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User.currentUser
        
        print("display current user from Accounts view controller: \(user)")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        users.append(user)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: {
            // segue to the next view controller
            print("I've logged in!")
            
        }, failure: { (error: Error) in
            print("error: \(error.localizedDescription)")
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users != nil {
            return users!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        
        let user = users[indexPath.row]
        
        if user.profileUrl != nil {
            cell.accountCellProfileImageView.setImageWith((user.profileUrl!))
        } else {
            cell.accountCellProfileImageView.image = UIImage(named:"bizimage-small.png")
        }

        cell.accountCellNameLabel.text = user.name
        cell.accountCellScreenNameLabel.text = "@\(user.screenname ?? "missing_handle")"
        
        return cell
    }
}
