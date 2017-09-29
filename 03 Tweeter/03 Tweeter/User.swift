//
//  User.swift
//  03 Tweeter
//
//  Created by YingYing Zhang on 9/28/17.
//  Copyright © 2017 Hearsay Systems. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    init(dictionary: NSDictionary) {
    
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString) as! URL
        }
        
        tagline = dictionary["description"] as? String
 
    }
}
