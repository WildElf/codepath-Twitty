//
//  TweetsViewController.swift
//  Conway
//
//  Created by Eric Zim on 2/21/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var tweets: [Tweet]?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
			
			self.tweets = tweets

			for tweet in tweets {
				print(tweet.text)
				
			}

			}, failure: { (error: NSError) -> () in
				print("error: \(error.localizedDescription)")
			})
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		self.tableView.reloadData()
	}
	
	@IBAction func onLogout(sender: AnyObject) {
		TwitterClient.sharedInstance.logout()
		
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let tweets = tweets {
			return tweets.count
		} else {
			return 0
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetViewCell
		
		let tweet = self.tweets![indexPath.row]
		
		cell.userNameLabel.text = tweet.user!.name
		cell.screenNameLabel.text = tweet.user!.screenName
		cell.createdAtLabel.text = tweet.createdAtString
		cell.tweetTextView.text = tweet.text
		cell.retweetCount.text = String(tweet.retweetCount)
		cell.favoriteCount.text = String(tweet.favoriteCount)
		
		self.tableView.reloadData()
		
		print("row \(indexPath.row)")
		
		return cell
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
