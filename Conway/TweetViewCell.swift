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


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
			
    }
	

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
