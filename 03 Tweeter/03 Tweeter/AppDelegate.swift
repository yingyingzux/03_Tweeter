//
//  AppDelegate.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/27/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let logger = AFNetworkActivityLogger.shared().loggers.first as? AFNetworkActivityLoggerProtocol {
            logger.level = .AFLoggerLevelDebug
        }
        AFNetworkActivityLogger.shared().startLogging()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //print(url.description)
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "c6swN7N237KLpzIPZcSpaUjBm", consumerSecret: "PKN22t0T4XnBDhoT54N5mKdF0GMDcogsItko5mp3IrAx5qOEwm")
        
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            //print("I got the access token!")
            
            twitterClient?.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
                //print("account: \(response)")
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                
                print("user: \(user)")
                print("name: \(user.name)")
                print("profileUrlString:\(user.profileUrl)")
                
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                print("error:\(error.localizedDescription)")
            })
            
            twitterClient?.get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
                //print("timeline: \(response)")
                
                let tweets = response as! [NSDictionary]
                
                /*
                for tweet in tweets {
                    print("\(tweet["text"]!)")
                }
                 */
                
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                print("error:\(error.localizedDescription)")
            })
            
        }, failure: { (error: Error!) in
            print("error:\(error.localizedDescription)")
        })

        
        return true
    }
    
    
}

