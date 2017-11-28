//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by NiKhil AroRa on 28/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

	@IBOutlet weak var tweetProfileImageView: UIImageView!
	@IBOutlet weak var tweetCreatedDate: UILabel!
	@IBOutlet weak var tweetUserName: UILabel!
	@IBOutlet weak var tweetDetails: UILabel!

	var tweet: Twitter.Tweet? {
		didSet {
			updateUI()
		}
	}

	private func updateUI() {
		tweetDetails?.text = tweet?.text
		tweetUserName?.text = tweet?.user.name

		if let profileImageURL = tweet?.user.profileImageURL {
			DispatchQueue.global(qos: .userInitiated).async { [weak self] in
				let imageData = try? Data(contentsOf: profileImageURL)
				if let tweetData = imageData {
					DispatchQueue.main.async {
						self?.tweetProfileImageView?.image = UIImage(data: tweetData)
					}
				}
			}
		} else {
			tweetProfileImageView?.image = nil
		}

		if let created = tweet?.created {
			let formatter = DateFormatter()
			if Date().timeIntervalSince(created) > 24*60*60 {
				formatter.dateStyle = .short
			} else {
				formatter.timeStyle = .short
			}
			tweetCreatedDate?.text = formatter.string(from: created)
		} else {
			tweetCreatedDate?.text = nil
		}
	}


}
