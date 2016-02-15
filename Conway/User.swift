//
//  User.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "CurrentUserKey"
let userDefaults = NSUserDefaults.standardUserDefaults()

class User: NSObject {
	var name: String?
	var screenName: String?
	var profileImageURL: String?
	var desc: String?
	
	var dictionary: NSDictionary?
	
	init(dictionary: NSDictionary) {
		self.dictionary = dictionary
		
		name = dictionary["name"] as? String
		screenName = dictionary["screen_name"] as? String
		profileImageURL = dictionary["profile_image_url"] as? String
		desc = dictionary["description"] as? String
	}
	
	class var currentUser: User? {
		get {
		
		if _currentUser == nil {
			let data = userDefaults.objectForKey(currentUserKey) as? NSData
			do {
			if data != nil {
				if let dictionary = try NSJSONSerialization.JSONObjectWithData(data!,
					options:NSJSONReadingOptions(rawValue:0)) as? NSDictionary {
					_currentUser?.dictionary = dictionary
				}
			}
		} catch {
				print("dictionary error")
			}
		
		}
		return _currentUser
		}
		set(user) {
			_currentUser = user
			
			if _currentUser != nil {
				do {
					// Start by converting the NSData to a dictionary - a dictionary for the entire response
					if let data = try NSJSONSerialization.dataWithJSONObject((user?.dictionary)!, options: []) as NSData!{
						userDefaults.setObject(data, forKey: currentUserKey) }
					} catch {
					print("Error parsing JSON")
				}
			} else {
				userDefaults.setObject(nil, forKey: currentUserKey)
			}
			
			userDefaults.synchronize()
		}
	}
	
}
