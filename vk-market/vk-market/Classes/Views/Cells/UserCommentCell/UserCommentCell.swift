//
//  UserCommentCell.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class UserCommentCell: UITableViewCell {

    @IBOutlet private weak var logoView: UIImageView! {
        didSet {
            self.logoView.layer.cornerRadius = self.logoView.frame.height / 2
            self.logoView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(comment: Comment) {
        if let profile = comment.profile {
            self.logoView.sd_setImage(with: URL(string: profile.photo100 ?? ""), completed: nil)
            self.usernameLabel.text = "\(profile.firstName) \(profile.lastName)"
        }
        self.commentLabel.text = comment.text
        self.dateLabel.text = Date(timeIntervalSince1970: TimeInterval(comment.date)).format(string: "hh:mm")
    }
    
}
