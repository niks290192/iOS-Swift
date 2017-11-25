//
//  ImageViewController.swift
//  Cassini
//
//  Created by NiKhil AroRa on 23/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

	@IBOutlet weak var imageScrollView: UIScrollView! {
		didSet{
			imageScrollView.delegate = self
			imageScrollView.minimumZoomScale = 0.03
			imageScrollView.maximumZoomScale = 2.0
			imageScrollView.contentSize = imageView.frame.size
			imageScrollView.addSubview(imageView)
		}
	}

	var imageURL: URL? {
		didSet {
			image = nil
			if view.window != nil {
				fetchImage()
			}
		}
	}


	@IBOutlet weak var spinner: UIActivityIndicatorView!

	private func fetchImage() {
		if let url = imageURL {
			spinner.startAnimating()
			DispatchQueue.global(qos: .userInitiated).async { [weak self] in
				let URLContents = try? Data(contentsOf: url)
				if let imageData = URLContents, url == self?.imageURL {
					DispatchQueue.main.async {
						self?.image = UIImage(data: imageData)
					}
				}
			}

		}
	}


	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if image == nil {
			fetchImage()
		}
	}


	fileprivate var imageView = UIImageView()

	private var image: UIImage? {
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
			imageScrollView?.contentSize = imageView.frame.size
			spinner?.stopAnimating()
		}
	}
}

extension ImageViewController : UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
