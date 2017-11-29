//
//  SmashTweetTableViewController.swift
//  Smashtag
//
//  Created by NiKhil AroRa on 29/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController {

	var container:NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

	override func insertTweets(_ newTweets: [Twitter.Tweet]) {
		super.insertTweets(newTweets)
		updateDatabase(with: newTweets)
	}

	private func updateDatabase(with tweets:[Twitter.Tweet]) {
		container?.performBackgroundTask { (context) in
			for tweetInfo in tweets {
				 
			}
		}
	}

}
