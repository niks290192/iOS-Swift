 //
//  ViewController.swift
//  Faceit
//
//  Created by NiKhil AroRa on 04/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController {

	@IBOutlet weak var faceView: FaceView! {
		didSet {
			let handlerPinch = #selector(faceView.changeScale(byReactingTo:))
			let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handlerPinch)
			faceView.addGestureRecognizer(pinchRecognizer)
//			let handlerTap = #selector(FaceViewController.toggleEyes(byReactingTo:))
//			let tapGesture = UITapGestureRecognizer(target: self, action: handlerTap)
//			tapGesture.numberOfTapsRequired = 1
//			faceView.addGestureRecognizer(tapGesture)
			let handlerSwipeUp = #selector(FaceViewController.increaseHappiness)
			let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: handlerSwipeUp)
			swipeUpGesture.direction = .up
			faceView.addGestureRecognizer(swipeUpGesture)
			let handleSwipeDown = #selector(FaceViewController.decreaseHappiness)
			let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: handleSwipeDown)
			swipeDownGesture.direction = .down
			faceView.addGestureRecognizer(swipeDownGesture)
			updateUI()
		}
	}

	private struct HeadShake {
		static let angle = CGFloat.pi/6
		static let segmentDuration:TimeInterval = 0.5
	}

	private func rotateFace(by angle: CGFloat) {
		faceView.transform = faceView.transform.rotated(by: angle)
	}

	@IBAction func shakeHead(_ sender: UITapGestureRecognizer) {
		shakeHead()
	}
	private func shakeHead() {
		UIView.animate(
			withDuration: HeadShake.segmentDuration,
			animations: { self.rotateFace(by: HeadShake.angle) }) { finished in
				if finished {
					UIView.animate(
						withDuration: HeadShake.segmentDuration,
						animations: { self.rotateFace(by: -HeadShake.angle*2) },
						completion: { finished in
							UIView.animate(withDuration: HeadShake.segmentDuration, animations: {
								self.rotateFace(by: HeadShake.angle)
							})
					})
				}
		}
	}
	var expression = FacialExpression(eyes: .open, mouth: .grin) {
		didSet {
			updateUI()
		}
	}

	@objc func toggleEyes(byReactingTo tapRecognizer:UITapGestureRecognizer) {
		if tapRecognizer.state == .ended {
			let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
			expression = FacialExpression.init(eyes: eyes, mouth: expression.mouth)
		}
	}

	@objc func increaseHappiness() {
		expression = expression.happier
	}

	@objc func decreaseHappiness() {
		expression = expression.sadder
	}

	func updateUI() {
		switch expression.eyes {
		case .open:
			faceView?.eyesOpen = true
		case .closed:
			faceView?.eyesOpen = false
		case .squinting:
			//faceView?.eyesOpen = false
			break
		}

		faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
	}

	private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile:1.0,.neutral:0.0,.smirk:-0.5]

}

