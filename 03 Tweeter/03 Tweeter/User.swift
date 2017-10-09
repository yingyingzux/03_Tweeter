//
//  User.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/28/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: Int?
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var profileBackgroundUrl: URL?
    var tagline: String?
    var location: String?
    var tweetCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        //print("current user: \(self.dictionary)")
        id = dictionary["id"] as? Int
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString) as! URL
        }
        
        let profileBackgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundUrlString = profileBackgroundUrlString {
            profileBackgroundUrl = NSURL(string: profileBackgroundUrlString) as! URL
        }
        
        tagline = dictionary["description"] as? String
        
        location = dictionary["location"] as? String
        
        tweetCount = dictionary["statuses_count"] as? Int
        
        followersCount = dictionary["followers_count"] as? Int
        
        followingCount = dictionary["friends_count"] as? Int
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
            
                let userData = defaults.object(forKey: "currentUserData") as? NSData
            
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                print("set user data if")
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                print("set user data else")
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()

        }
    }
    
    class func usersWithArray(dictionaries: [NSDictionary]) -> [User] {
        var users = [User]()
        
        for dictionary in dictionaries {
            let user = User(dictionary: dictionary)
            users.append(user)
            
        }
        
        return users
    }
}
