//
//  Tweet.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/28/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var profileImageViewUrl: URL?
    var retweetAuthorName: String?
    var userDictionary: NSDictionary?
    var tweetAuthorName: String?
    var tweetHandle: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var id: Int = 0
    var idRetweetOriginal: Int = 0
    
    var userId: Int = 0
    var userIdRetweetOriginal: Int = 0
    
    var retweetedStatusDictionary: NSDictionary?
    var retweetedUserDictionary: NSDictionary?
    
    var text: String?
    
    init(dictionary: NSDictionary) {
        
        userDictionary = dictionary["user"] as? NSDictionary
        retweetedStatusDictionary = dictionary["retweeted_status"] as? NSDictionary
        
        //id = dictionary["id"] as! Int // tweet id
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        if retweetedStatusDictionary != nil { // retweetStatusDictionary exits
            retweetedUserDictionary = retweetedStatusDictionary?["user"] as? NSDictionary
            retweetAuthorName = userDictionary?["name"] as? String
            //idRetweetOriginal = retweetedStatusDictionary?["id"] as! Int // tweet id
            
            userIdRetweetOriginal = (retweetedUserDictionary?["id"] as? Int)!
            //print("retweetedUserDictionary: \(retweetedUserDictionary)")
            
            let profileImageViewUrlString = retweetedUserDictionary?["profile_image_url_https"] as? String
            
            if profileImageViewUrlString != nil {
                profileImageViewUrl = URL(string:profileImageViewUrlString!)!
            } else {
                profileImageViewUrl = nil
            }
            
            
            let timestampString = retweetedStatusDictionary!["created_at"] as? String
            
            if let timestampString = timestampString {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
                timestamp = formatter.date(from: timestampString)
            }
            
            tweetAuthorName = retweetedUserDictionary?["name"] as? String
            
            //print("tweetAuthorName - aka retweetedUserDictionary: \(tweetAuthorName)")
            
            
            tweetHandle = retweetedUserDictionary?["screen_name"] as? String
            
            text = retweetedStatusDictionary!["text"] as? String
            
        } else { // doesn't exist
            let profileImageViewUrlString = userDictionary?["profile_image_url_https"] as? String
            
            if profileImageViewUrlString != nil {
                profileImageViewUrl = URL(string:profileImageViewUrlString!)!
            } else {
                profileImageViewUrl = nil
            }
            
            tweetAuthorName = userDictionary?["name"] as? String
            tweetHandle = userDictionary?["screen_name"] as? String
            userId = (userDictionary?["id"] as? Int)!
            
            let timestampString = dictionary["created_at"] as? String
            
            if let timestampString = timestampString {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
                timestamp = formatter.date(from: timestampString)
            }

            
            text = dictionary["text"] as? String
            
            //print("userDictionary: \(userDictionary)")

        }
        
        
        //text = dictionary["text"] as? String
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
    
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
    
        }
    
        return tweets
    }

}
