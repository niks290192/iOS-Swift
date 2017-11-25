//
//  DemoURL.swift
//  Cassini
//
//  Created by NiKhil AroRa on 23/11/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import Foundation

struct DemoURL {

	static let stanford = URL(string: "https://www-media.stanford.edu/wp-content/uploads/2017/11/16141818/terman-splash-landscape-767x511.jpg")

	static var NASA: Dictionary<String, URL> = {
		let NASAURLStrings = [
			"Cassini" : "https://scontent-dft4-1.cdninstagram.com/t51.2885-15/e35/23969363_293160171203361_6891942185176924160_n.jpg",
			"Earth" : "https://scontent-dft4-1.cdninstagram.com/t51.2885-15/e35/23969363_293160171203361_6891942185176924160_n.jpg",
			"Saturn": "https://scontent-dft4-1.cdninstagram.com/t51.2885-15/e35/23969363_293160171203361_6891942185176924160_n.jpg"
		]

		var urls = Dictionary<String,URL>()
		for (key,value) in NASAURLStrings {
			urls[key] = URL(string:value)
		}
		return urls
	}()
}
