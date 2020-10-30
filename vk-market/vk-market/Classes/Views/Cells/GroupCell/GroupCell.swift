//
//  GroupCell.swift
//  vk-market
//
//  Created by Александр on 29.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class GroupCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var logoView: UIImageView! {
        didSet {
            self.logoView.layer.cornerRadius = 4
            self.logoView.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(_ item: Group) {
        self.logoView.sd_setImage(with: URL.init(string: item.photo200), completed: nil)
        self.titleLabel.text = item.name
    }
    
}
