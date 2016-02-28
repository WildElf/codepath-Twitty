//
//  Tweet.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

class Tweet: NSObject {
	let user: User?
	let text: String?
	let createdAtString: String?
	let createdAt: NSDate?

	var retweetCount: Int = 0;
	var favoriteCount: Int = 0;
	let retweetDefaultLocalPath = NSURL(fileURLWithPath: "retweet-action.png")
	let favoriteDefaultLocalPath = NSURL(fileURLWithPath: "like-action.png")
	
	var profileImageURL: NSURL?
	var tweetImageURL: NSURL?

	init(dictionary: NSDictionary) {
		user = User(dictionary: dictionary["user"] as! NSDictionary)
		text = dictionary["text"] as? String
		createdAtString = dictionary["created_at"] as? String
		retweetCount = (dictionary["retweet_count"] as? Int) ?? 0;
		favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0;

		// determine profile image
		if let profileImageURLString = dictionary["profile_image_url"] as? String {
			print("profile image: \(profileImageURLString)")
			self.profileImageURL = NSURL(string: profileImageURLString)
		} else {
			print("no profile image, let's go Conway!")
			self.profileImageURL = NSURL(fileURLWithPath: "conway_twitty_sillhoette_400.png")
		 
		}
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
		createdAt = formatter.dateFromString(createdAtString!)
	}
	
	class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
		var tweets = [Tweet]()
		
		for dictionary in dictionaries {
			tweets.append(Tweet(dictionary: dictionary))
		}
		
		return tweets
	}

}
