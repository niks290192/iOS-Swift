//
//  EmotionsViewController.swift
//  Faceit
//
//  Created by NiKhil AroRa on 20/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		var destinationViewController = segue.destination
		if let navigationController = destinationViewController as? UINavigationController {
			destinationViewController = navigationController.visibleViewController ?? destinationViewController
		}
		if let faceViewController = destinationViewController as? FaceViewController,
			let cell = sender as? UITableViewCell,
			let indexPath = tableView.indexPath(for: cell){
			faceViewController.expression = emotionFaces[indexPath.row].expression
			faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
		} else if destinationViewController is ExpressionEditorViewControllerTableViewController {
			if let popoverPresentationViewController = segue.destination.popoverPresentationController {
				popoverPresentationViewController.delegate = self
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emotionFaces.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
		cell.textLabel?.text = emotionFaces[indexPath.row].name
		return cell
	}

	@IBAction func addEmotinalFace(from segue: UIStoryboardSegue) {
		if let editor = segue.source as? ExpressionEditorViewControllerTableViewController {
			emotionFaces.append((editor.name, editor.facialExpression))
			tableView.reloadData()
		}
	}

	private var emotionFaces: [(name: String, expression:FacialExpression)] = [
		("Sad", FacialExpression(eyes: .closed, mouth: .frown)),
		("Happy", FacialExpression(eyes: .open, mouth: .smile)),
		("Happy", FacialExpression(eyes: .open, mouth: .smirk))
	]

	func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
		if traitCollection.verticalSizeClass == .compact {
			return .none
		} else if traitCollection.horizontalSizeClass == .compact {
			return .overFullScreen
		} else {
			return .none
		}
	}
}
