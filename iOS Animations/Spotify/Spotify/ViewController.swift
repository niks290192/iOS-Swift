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
		UIView.animate(withDuration: 1.0, animations: {
			self.backgroundImage.alpha = 1.0
		}, completion: nil)

		UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
			self.continueButton.alpha = 1.0
			self.continueButton.center.y -= 30
		}) { finished in
			self.marketingMessage(0)
		}
	}

	private func marketingMessage(_ indexi: Int) {
		var index:Int = indexi
		let message = messages[index]
		self.message.text = message
		self.message.center.y += 30

		UIView.animateKeyframes(withDuration: 10.0, delay: 0.0, options: [], animations: {
			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.10, animations: {
				self.message.alpha = 0.5
			})

			UIView.addKeyframe(withRelativeStartTime: 0.10, relativeDuration: 0.05, animations: {
				self.addKeyanimation()
			})

			UIView.addKeyframe(withRelativeStartTime: 0.90, relativeDuration: 0.05, animations: {
				self.message.alpha = 0.0
			})

		}) { (finished) in
			if index == self.messages.count - 1 {
				index = 0
			} else {
				index = index+1
			}
		}
	}

	//Unary Operator "++" cannot be applied to an operand of type

	private func addKeyanimation() {
		UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [.curveEaseOut], animations: {
			self.message.center.y -= 30.0
		}, completion: nil)
	}

}

