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
	
	init(dictionary: NSDictionary) {
		user = User(dictionary: dictionary["user"] as! NSDictionary)
		text = dictionary["text"] as? String
		createdAtString = dictionary["created_at"] as? String
		retweetCount = (dictionary["retweet_count"] as? Int) ?? 0;
		favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0;
		
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
