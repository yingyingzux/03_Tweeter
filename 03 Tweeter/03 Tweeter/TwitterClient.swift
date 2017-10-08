//
//  TwitterClient.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/29/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "c6swN7N237KLpzIPZcSpaUjBm", consumerSecret: "PKN22t0T4XnBDhoT54N5mKdF0GMDcogsItko5mp3IrAx5qOEwm")
    
    //static let isThereNewTweet = false
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytweeter://oauth")! as URL, scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
            UIApplication.shared.openURL(url as URL)
            
        }) { (error: Error!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        TwitterClient.sharedInstance?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
                self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                print("login success. got token in handleOpenUrl")
                    
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
        }, failure: { (error: Error!) in
            print("error:\(error.localizedDescription)")
            self.loginFailure?(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        
        TwitterClient.sharedInstance?.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        TwitterClient.sharedInstance?.get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            //print("get timeline")
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            /*
            for tweet in tweets {
                print ("tweet: \(dictionaries)")
            }
             */
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        TwitterClient.sharedInstance?.get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            print("get mentions timeline")
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            /*
             for tweet in tweets {
             print ("mentions tweet: \(dictionaries)")
             }
            */
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func userTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        TwitterClient.sharedInstance?.get("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            print("get user timeline")
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            /*
             for tweet in tweets {
             print ("mentions tweet: \(dictionaries)")
             }
             */
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func postNewTweet(text: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let params = ["status": text]
        TwitterClient.sharedInstance?.post("/1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            // add code for success
            
            let tweetDictionary = response as! NSDictionary
            let newTweet = Tweet(dictionary: tweetDictionary)
            
            success(newTweet)
            
            print("post new tweet success")
            
        } as! (URLSessionDataTask, Any?) -> Void, failure: { (task: URLSessionDataTask?, error: Error) in
            print("\(error.localizedDescription)")
        })
        
     }
    
    func favTweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let params = ["id": id]
        
        TwitterClient.sharedInstance?.post("/1.1/favorites/create.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let tweetDictionary = response as! NSDictionary
            let favedTweet = Tweet(dictionary: tweetDictionary)
            
            success(favedTweet)
            
            print("Fav a tweet success")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("\(error.localizedDescription)")
        })
    }
    
    func unFavTweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let params = ["id": id]
        
        TwitterClient.sharedInstance?.post("/1.1/favorites/destroy.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let tweetDictionary = response as! NSDictionary
            let unFavedTweet = Tweet(dictionary: tweetDictionary)
            
            success(unFavedTweet)
            
            print("Unfav a tweet success")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("\(error.localizedDescription)")
        })
    }

    
    func retweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let path = "/1.1/statuses/retweet/\(id).json"
        TwitterClient.sharedInstance?.post(path, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let tweetDictionary = response as! NSDictionary
            let retweetedTweet = Tweet(dictionary: tweetDictionary)
            
            success(retweetedTweet)
            print("Retweet a tweet success")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("\(error.localizedDescription)")
        })
    }
    
    func unRetweet(id: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        let path = "/1.1/statuses/retweet/\(id).json"
        
        TwitterClient.sharedInstance?.post(path, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let tweetDictionary = response as! NSDictionary
            let unRetweetedTweet = Tweet(dictionary: tweetDictionary)
            
            success(unRetweetedTweet)
            print("unRetweet a tweet success")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("\(error.localizedDescription)")
        })
    }
    
}


