//
//  ProductCollectionCell.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var pictureView: UIImageView! {
        didSet {
            self.pictureView.layer.cornerRadius = 4
            self.pictureView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(item: Productable) {
        self.descriptionLabel.text = item.title
        self.priceLabel.text = item.priceString
        self.pictureView.sd_setImage(with: item.pictureURL, completed: nil)
    }

}
