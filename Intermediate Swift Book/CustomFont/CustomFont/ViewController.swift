//
//  ViewController.swift
//  CustomFont
//
//  Created by Simon Ng on 27/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label1:UILabel!
    @IBOutlet weak var label2:UILabel!
    @IBOutlet weak var label3:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        label1.font = UIFont(name: "Mohave-Italic", size: 25.0)
        label2.font = UIFont(name: "Hallo sans", size: 30.0)
        label3.font = UIFont(name: "CanterLight", size: 35.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

