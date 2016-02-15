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
	
	var loginCompletion: ((user: User?, error: NSError?) -> ())?
	
	class var sharedInstance: TwitterClient {
		struct Static {
			static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
		}
		
		return Static.instance;
	}
	
	func loginWithCompletion (completion: (user: User?, error: NSError?) -> ()) {
		loginCompletion = completion
		
		// fetch request token and go to authorization page
		TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
		TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "conwaytwitty://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
			print("Got the request token")
			let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
			UIApplication.sharedApplication().openURL(authURL!)
			
			}) { (error: NSError!) -> Void in
				print("Request token get failed")
				self.loginCompletion?(user: nil, error: error)
		}
	}
	
	func openURL(url: NSURL) {
		
		fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
			
			print("access token got")
			TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
			
			TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
				// print("user: \(response!)")
				let user = User(dictionary: response as! NSDictionary)
				User.currentUser = user
				print("user: \(user.name)")
				self.loginCompletion?(user: user, error: nil)
				}, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
					print("failed getting current user")
					self.loginCompletion?(user: nil, error: error)
			})
			
			TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
				// print("home_timeline: \(response!)")
				let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
				
//				for tweet in tweets {
//					print("text: \(tweet.text), created at: \(tweet.createdAt)")
//				}
				}, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
					print("failed getting current timeline")
			})
			
			}) { (error: NSError!) -> Void in
				print("failed to get access token")
				self.loginCompletion?(user: nil, error: error)
		}
		
	}
}
