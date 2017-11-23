//
//  ImageViewController.swift
//  Cassini
//
//  Created by NiKhil AroRa on 23/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

	var imageURL: URL? {
		didSet {
			image = nil
			fetchImage()
		}
	}

	private func fetchImage() {
		if let url = imageURL {
			let URLContents = try? Data(contentsOf: url)
			if let imageData = URLContents {
				image = UIImage(data: imageData)
			}
		}
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(imageView)
	}


	private var imageView = UIImageView()

	private var image: UIImage? {
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
		}
	}

}
