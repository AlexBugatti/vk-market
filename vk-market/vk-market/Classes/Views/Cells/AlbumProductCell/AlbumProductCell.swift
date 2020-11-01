//
//  AlbumProductCell.swift
//  vk-market
//
//  Created by Александр on 01.11.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class AlbumProductCell: UICollectionViewCell {

    @IBOutlet private weak var logoView: UIImageView! {
        didSet {
            self.logoView.layer.cornerRadius = 4
            self.logoView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(item: Productable) {
        self.titleLabel.text = item.title
        self.priceLabel.text = item.priceString
        self.logoView.sd_setImage(with: item.pictureURL, completed: nil)
    }
    
}
