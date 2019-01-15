//
//  IconTableViewCell.swift
//  CollectionViewDemo
//
//  Created by Simon Ng on 8/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class IconTableViewCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
