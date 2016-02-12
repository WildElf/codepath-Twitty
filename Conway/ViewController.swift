//
//  ViewController.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func onLogin(sender: AnyObject) {
		TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
		TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "conwaytwitty://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
			print("Got the request token")
			let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
			UIApplication.sharedApplication().openURL(authURL!)
			
			}) { (error: NSError!) -> Void in
				print("Request token get failed")
		}
	}
	
}

