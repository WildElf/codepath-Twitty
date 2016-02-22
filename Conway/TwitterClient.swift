//
//  TwitterClient.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
	
	static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "VnkOHnkh1NyWKDAL4qvKJQsBt", consumerSecret: "hKCHa7WCva8gd4QJJiahBjjrjO9UFggy8rhad7ZsogtiiJrplx")
	
	var loginSuccess: (() -> ())?
	var loginFailure: ((NSError) -> ())?
	let twitterClient = TwitterClient.sharedInstance;
	
	//	var loginCompletion: ((user: User?, error: NSError?) -> ())?
	
	
	func login (success: () -> (), failure: (NSError) -> ()) {
		loginSuccess = success;
		loginFailure = failure;
		
		// fetch request token and go to authorization page
		twitterClient.deauthorize();
		twitterClient.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "conwaytwitty://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
			print("Got the request token")
			
			let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)");
			UIApplication.sharedApplication().openURL(url!);
			
			}) { (error: NSError!) -> Void in
				print("error \(error.localizedDescription)")
		}
	}
	
	func handleOpenUrl(url: NSURL) {
		
		let requestToken = BDBOAuth1Credential(queryString: url.query);
		fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
			
			self.currentAccount({ (user: User) -> () in
				User.currentUser = user;
				self.loginSuccess?();
				}, failure: { (error: NSError) -> () in
					self.loginFailure?(error);
					
			})
			
			
			}) { (error: NSError!) -> Void in
				print("error \(error.localizedDescription)")
		}
		
	}
	
	
	func homeTimeline (success: ([Tweet]) -> (), failure: (NSError) -> ()) {
		GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
			// print("home_timeline: \(response!)")
			let tweets = response as! [Tweet]
			
			success(tweets);
			
			}, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
				failure(error);
		})
	}
	
	func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
		GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
			
			let userDictionary = response as! NSDictionary;
			let user = User(dictionary: userDictionary)
			
			success(user)
			
			}, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
				failure(error)
		})
		
	}
	
	func logout () {
		User.currentUser = nil
		deauthorize()
		
		NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
	}
	
	
}

/*
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

*/
