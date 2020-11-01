//
//  AlbumCell.swift
//  vk-market
//
//  Created by Александр on 31.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumCell: UICollectionViewCell {

    @IBOutlet private weak var logoView: UIImageView! {
        didSet {
            self.logoView.layer.cornerRadius = 5
            self.logoView.layer.masksToBounds = true
            self.logoView.layer.borderColor = Pallete.separateColor.cgColor
            self.logoView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ album: Album) {
        
        if let photo = album.photo {
            self.logoView.contentMode = .scaleAspectFill
            self.logoView.sd_setImage(with: URL(string: photo.photoURL ?? ""), completed: nil)
        } else {
            self.logoView.image = #imageLiteral(resourceName: "collage")
            self.logoView.contentMode = .center
        }
        self.titleLabel.text = album.title
        self.countLabel.text = "\(album.count) предложений"
    }

}
