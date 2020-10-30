//
//  CommentView.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class CommentView: NibView {

    var onDidTapped: (()->())?
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBAction func onDidTapped(_ sender: Any) {
        self.onDidTapped?()
    }
    
    func setComments(count: Int) {
        self.commentLabel.text = "Комментарии"
        if count > 0 {
            self.commentLabel.text = "Комментарии (\(count))"
        }
    }
    
    func setLikes(count: Int) {
        self.likeCountLabel.text = "\(count)"
        self.likeCountLabel.isHidden = count == 0
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
