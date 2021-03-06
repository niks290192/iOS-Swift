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


	private func showSizeClasses() {
		if !userIsInTheMiddleOfTyping {
			display.textAlignment = .center
			display.text = "width: \(traitCollection.horizontalSizeClass.rawValue)  height:  \(traitCollection.verticalSizeClass.rawValue)"
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		showSizeClasses()
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: { coordinator in
			self.showSizeClasses()
		}, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		brain.addUnaryOperation(named: "✅") { [weak weakSelf = self] in
			weakSelf?.display.textColor = UIColor.green
			return sqrt($0)
		}
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

	private var brain = CalculatorBrain()

	@IBAction func preformOperation(_ sender: UIButton) {
		if userIsInTheMiddleOfTyping {
			brain.setOperand(displayValue)
			userIsInTheMiddleOfTyping = false
		}

		if let mathematicalSymbol = sender.currentTitle {
			brain.preformOperation(mathematicalSymbol)
		}

		if let result = brain.result {
			displayValue = result
		}
	}
}

extension UIUserInterfaceSizeClass : CustomStringConvertible {
	public var description: String {
		switch self {
		case .compact:
			return "compact"
		case .regular:
			return "regular"
		case .unspecified:
			return "??"
		}
	}
}

