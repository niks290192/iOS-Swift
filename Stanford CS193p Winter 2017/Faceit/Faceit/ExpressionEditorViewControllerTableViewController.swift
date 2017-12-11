//
//  ExpressionEditorViewControllerTableViewController.swift
//  Faceit
//
//  Created by NiKhil AroRa on 11/12/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ExpressionEditorViewControllerTableViewController: UITableViewController, UITextFieldDelegate {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var eyeControl: UISegmentedControl!
	@IBOutlet weak var mouthControl: UISegmentedControl!

	var name: String {
		return nameTextField?.text ?? ""
	}

	private let eyeChoices =  [FacialExpression.Eyes.open, .closed, .squinting]
	private let mouthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .grin, .smile]

	var facialExpression:FacialExpression {
		return FacialExpression(eyes: eyeChoices[eyeControl?.selectedSegmentIndex ?? 0], mouth: mouthChoices[mouthControl?.selectedSegmentIndex ?? 0])
	}


	@IBAction func updateFace() {
		faceViewController?.expression = facialExpression
	}

	private var faceViewController: BlinkingFaceViewController?

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "Embed Face" {
			faceViewController = segue.destination as? BlinkingFaceViewController
			faceViewController?.expression = facialExpression
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let popoverPresentationController = navigationController?.popoverPresentationController {
			if popoverPresentationController.arrowDirection != .unknown {
				navigationItem.leftBarButtonItem = nil
			}
		}

		var size = tableView.minimumSize(forSection: 0)
		size.height -= tableView.heightForRow(at: IndexPath(row: 1, section: 0))
		size.width += size.width
		preferredContentSize = size
	}


	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 1 {
			return tableView.bounds.size.width
		} else {
			return super.tableView(tableView, heightForRowAt: indexPath)
		}
	}


	@IBAction func cancel(_ sender: UIBarButtonItem) {
		presentingViewController?.dismiss(animated: true)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}

extension UITableView {
	func minimumSize(forSection section:Int) -> CGSize {
		var width:CGFloat = 0
		var height:CGFloat = 0
		for row in 0..<numberOfRows(inSection: section) {
			let indexPath = IndexPath(row: row, section: section)
			if let cell = cellForRow(at: indexPath) ?? dataSource?.tableView(self, cellForRowAt: indexPath) {
				let cellSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
				width = max(width, cellSize.width)
				height += heightForRow(at: indexPath)
			}
		}

		return CGSize(width: width, height: height)
	}

	func heightForRow(at indexPath: IndexPath? = nil) -> CGFloat {
		if indexPath != nil, let height = delegate?.tableView?(self, heightForRowAt: indexPath!) {
			return height
		} else {
			return rowHeight
		}
	}

}
