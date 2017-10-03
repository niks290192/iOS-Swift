//
//  ViewController.swift
//  Calculator
//
//  Created by NiKhil AroRa on 03/10/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var display: UILabel!

	var userIsInTheMiddleOfTyping:Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	@IBAction func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		if userIsInTheMiddleOfTyping {
			let textCurrentlyInDisplay = display.text!
			display.text = textCurrentlyInDisplay + digit
		} else {
			display.text! = digit
			userIsInTheMiddleOfTyping = true
		}
	}

	var displayValue : Double {
		get{
			return Double(display.text!)!
		}
		set {
			display.text = String(newValue)
		}
	}

	@IBAction func preformOperation(_ sender: UIButton) {
		userIsInTheMiddleOfTyping = false
		if let mathematicalSymbol = sender.currentTitle {
			switch mathematicalSymbol {
			case "π":
				displayValue = Double.pi
			case "√":
				displayValue = sqrt(displayValue)
			default:
				break
			}
		}
	}



}

