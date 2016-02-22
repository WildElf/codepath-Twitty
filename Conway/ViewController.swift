//
//  ViewController.swift
//  Conway
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit
//import BDBOAuth1Manager

class LoginViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func onLogin(sender: AnyObject) {
		
		TwitterClient.sharedInstance.login( { () -> () in
			print("Logged in");
			
			self.performSegueWithIdentifier("loginSegue", sender: nil)
			}) { (error: NSError) -> () in
				print("error: \(error.localizedDescription)");
		}
	}
	
}

