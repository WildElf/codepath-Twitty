//
//  TweetViewCell.swift
//  Conway
//
//  Created by Eric Zim on 2/25/16.
//  Copyright © 2016 Eric Zim. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {
	
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var screenNameLabel: UILabel!
	@IBOutlet weak var createdAtLabel: UILabel!
	@IBOutlet weak var tweetTextView: UITextView!
	
	@IBOutlet weak var retweetCount: UILabel!
	@IBOutlet weak var favoriteCount: UILabel!
	
	@IBOutlet weak var profileImageView: UIImageView!
	
	@IBOutlet weak var tweetImageView: UIImageView!
	var tweetImageURL: NSURL?
	
	@IBOutlet weak var retweetImageView: UIImageView!
	@IBOutlet weak var favoriteImageView: UIImageView!
	
	var tweet: Tweet! {
		didSet {
			
			userNameLabel.text = tweet.user!.name
			screenNameLabel.text = tweet.user!.screenName
			createdAtLabel.text = tweet.createdAtString
			tweetTextView.text = tweet.text
			retweetCount.text = String(tweet.retweetCount)
			favoriteCount.text = String(tweet.favoriteCount)
			profileImageView.setImageWithURL(tweet.profileImageURL!)
			
			retweetImageView.setImageWithURL(tweet.retweetDefaultLocalPath)
			favoriteImageView.setImageWithURL(tweet.favoriteDefaultLocalPath)

			}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
	}
	
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
