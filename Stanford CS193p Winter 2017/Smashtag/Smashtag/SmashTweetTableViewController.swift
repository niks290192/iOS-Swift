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
		container?.performBackgroundTask { [weak self] (context) in
			for tweetInfo in tweets {
				 _ = try? Tweet.findOrCreateTweet(matching: tweetInfo, in: context)
			}
			try? context.save()
			print("done loading database")
			self?.printDatabaseStatistics()
		}

	}

	private func printDatabaseStatistics() {
		if let context = container?.viewContext {
			context.perform {
				if Thread.isMainThread {
					print("Main Thread")
				} else {
					print("Not a main Thread")
				}
				let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
				if let tweetCount = (try? context.fetch(request))?.count {
					print("\(tweetCount) tweets")
				}//Ambiguous use of 'fetchRequest'
				
				if let tweeterCount = try? context.count(for: TwitterUser.fetchRequest()) {
					print("\(tweeterCount) Twitter Users")
				}
			}
		}
	}

}
