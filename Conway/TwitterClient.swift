//
//  TwitterClient.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

let twitterConsumerKey = "VnkOHnkh1NyWKDAL4qvKJQsBt"
let twitterConsumerSecret = "hKCHa7WCva8gd4QJJiahBjjrjO9UFggy8rhad7ZsogtiiJrplx"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
	
	class var sharedInstance: TwitterClient {
		struct Static {
			static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
		}
		
		return Static.instance;
	}
}
