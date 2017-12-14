//
//  APIManager.swift
//  RandomQuote
//
//  Created by NiKhil AroRa on 13/12/17.
//  Copyright © 2017 Nikhil Arora. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
	func getQuoteData(completion: @escaping(_ quote:String, _ author:String?)-> Void) {
		let url = URL(string: quoteURL)!

		let config = URLSessionConfiguration.ephemeral
		let session = URLSession(configuration: config)

		let task = session.dataTask(with: url) { (data, response, error)-> Void in
			if error != nil {
				print(error!.localizedDescription)
			} else {
				do {
					let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
					let aQuote = json["quoteText"] as! String
					let aAuthor = json["quoteAuthor"] as! String
					DispatchQueue.global(qos: .background).async {
						DispatchQueue.main.async {
							completion(aQuote, aAuthor)
						}
					}
				} catch {
					print("JSON Serialization Error")
				}
			}
		}


		task.resume()
	}
}

