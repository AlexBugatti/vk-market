//
//  ProductTableCell.swift
//  vk-market
//
//  Created by Александр on 01.11.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class ProductTableCell: UITableViewCell {

    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(item: Productable) {
        self.titleLabel.text = item.title
        self.priceLabel.text = item.priceString
//        self.descriptionLabel.text = item.
        self.logoView.sd_setImage(with: item.pictureURL, completed: nil)
    }
    
}
