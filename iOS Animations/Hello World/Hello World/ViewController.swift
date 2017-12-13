//
//  ViewController.swift
//  Hello World
//
//  Created by NiKhil AroRa on 12/12/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var helloWorld: UILabel!
	@IBOutlet weak var secondLabel: UILabel!
	@IBOutlet weak var hiddenLabel: UILabel!



	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		helloWorld.center.y -= view.bounds.height
		secondLabel.center.y += view.bounds.height
		hiddenLabel.alpha = 0.0
	}


	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		UIView.animate(withDuration: 1.0, animations: {
			self.helloWorld.center.y += self.view.bounds.height
		}, completion: { finished in
			 self.secondAnimation()
		})

		UIView.animate(withDuration: 2.0, delay: 0.0, options: [], animations: {
			self.view.backgroundColor = UIColor.yellow
		}, completion: nil)
	}

	private func secondAnimation() {
		UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: {
			self.secondLabel.center.y -= self.view.bounds.height
		}, completion: { finished in
			self.backgroundColor()
		})
	}

	private func backgroundColor() {
		UIView.animate(withDuration: 2.5, animations: {
			self.view.backgroundColor = UIColor.black
		}, completion: nil)


		UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
			self.hiddenLabel.alpha = 1.0
		}, completion: nil)

	}



}

