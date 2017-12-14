//
//  ViewController.swift
//  RandomQuote
//
//  Created by NiKhil AroRa on 12/12/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var quoteLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		quoteLabel.alpha = 0.0
		authorLabel.alpha = 0.0
		setQuote()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func randomBtn(_ sender: UIButton) {
		setQuote()
	}

	private func setQuote() {
		fadeOut()
		let API = APIManager()
		API.getQuoteData { (quote, author) in
			UIView.animate(withDuration: 1.0, animations: {
				self.fadeIn()
				self.view.backgroundColor = self.getRandomColor()
				self.quoteLabel.text = quote
				if let _author = author {
					self.authorLabel.text = _author
				}

				if author == "" {
					self.authorLabel.text = "Unknown"
				}
			})
		}
	}

	private func fadeIn() {
		quoteLabel.alpha = 1.0
		authorLabel.alpha = 1.0
	}

	private func fadeOut() {
		quoteLabel.alpha = 0.0
		authorLabel.alpha = 0.0
	}

	private func getRandomColor() -> UIColor{
		let randomRed:CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
		let randomGreen:CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
		let randomBlue:CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))

		return UIColor(red: randomRed/255.0, green: randomGreen/255.0, blue: randomBlue/255.0, alpha: 0.8)
	}

}

