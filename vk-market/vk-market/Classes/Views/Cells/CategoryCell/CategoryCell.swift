//
//  CategoryCell.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet private weak var logoView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(_ item: Subcategory) {
        self.titleLabel.text = item.name
        self.logoView.image = UIImage(named: item.imageName) ?? nil
        self.logoView.tintColor = Pallete.color(item.imageColor)
    }
    
}
