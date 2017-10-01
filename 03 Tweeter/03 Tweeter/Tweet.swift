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
    var text: String?
    
    init(dictionary: NSDictionary) {
        
        userDictionary = dictionary["user"] as? NSDictionary
        
        let profileImageViewUrlString = userDictionary?["profile_image_url_https"] as? String
        
        if profileImageViewUrlString != nil {
            profileImageViewUrl = URL(string:profileImageViewUrlString!)!
        } else {
            profileImageViewUrl = nil
        }
        
        retweetAuthorName = dictionary["in_reply_to_screen_name"] as? String
        
        tweetAuthorName = userDictionary?["name"] as? String
        tweetHandle = userDictionary?["screen_name"] as? String
    
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        text = dictionary["text"] as? String
        
        
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
