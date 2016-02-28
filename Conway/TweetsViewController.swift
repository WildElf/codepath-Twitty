//
//  TweetsViewController.swift
//  Conway
//
//  Created by Eric Zim on 2/21/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var tweets: [Tweet]!
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
			
			self.tweets = tweets
			self.tableView.reloadData()

			//			self.tableView.estimatedRowHeight = 300
//			self.tableView.rowHeight = UITableViewAutomaticDimension
			
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
		print("view did appear")
	}
	
	@IBAction func onLogout(sender: AnyObject) {
		TwitterClient.sharedInstance.logout()
		
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		print("tweet count\(tweets?.count ?? 0)")
		return tweets?.count ?? 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetViewCell

		cell.tweet = tweets[indexPath.row]

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
