//
//  User.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

let userDefaults = NSUserDefaults.standardUserDefaults()

class User: NSObject {
	var name: String?
	var screenName: String?
	var desc: String?
	var profileImageURL: NSURL?
	
	var dictionary: NSDictionary?
	
	init(dictionary: NSDictionary) {
		self.dictionary = dictionary
		
		name = dictionary["name"] as? String
		screenName = dictionary["screen_name"] as? String
		desc = dictionary["description"] as? String

		let profileImageURLString = dictionary["profile_image_url"] as? String
		if let profileImageURLString = profileImageURLString {
			profileImageURL = NSURL(string: profileImageURLString)
		}
	}
	
	static var _currentUser: User?
	
	class var currentUser: User? {
		get {
		
			if _currentUser == nil {
				let userData = userDefaults.objectForKey("currentUserData") as? NSData
		
				if let userData = userData {
					let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
					_currentUser = User(dictionary: dictionary)
				}
			}
			return _currentUser
		}
		set(user) {
			
			_currentUser = user;
			
			if let user = user {
				do {
					// Start by converting the NSData to a dictionary - a dictionary for the entire response
					if let data = try NSJSONSerialization.dataWithJSONObject((user.dictionary)!, options: []) as NSData!{
						userDefaults.setObject(data, forKey: "currentUserData") }
				} catch {
					print("Error parsing JSON")
				}
			} else {
				userDefaults.setObject(nil, forKey: "currentUserData")
			}
			
			userDefaults.synchronize()
		}
	}
	
}
