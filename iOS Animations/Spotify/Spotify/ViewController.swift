//
//  ViewController.swift
//  Spotify
//
//  Created by NiKhil AroRa on 12/12/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var continueButton:UIButton!
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var message:UILabel!

	var messages = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.tintColor = UIColor.white

		messages = ["Music for everyone", "millions of songs on Spotify. Play your favorites, discover new tracks, and build the perfect collection", "Find readymade playlists to match your mood, put together by music fans and experts", " Hear this week’s latest singles and albums, and check out what’s hot in the Top 50"]
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		continueButton.alpha = 0.0
		backgroundImage.alpha = 0.0
		message.alpha = 0.0
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}


}

