//
//  LoginViewController.swift
//  Spotify
//
//  Created by NiKhil AroRa on 17/12/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var emailField:UITextField!
	@IBOutlet weak var passwordField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

		emailField.center.x -= view.bounds.width
		passwordField.center.x -= view.bounds.width
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
			self.emailField.center.x += self.view.bounds.width
		}, completion: nil)

		UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
			self.passwordField.center.x += self.view.bounds.width
		}, completion: nil)
	}

}
