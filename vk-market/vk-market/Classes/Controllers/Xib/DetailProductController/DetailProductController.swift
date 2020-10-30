//
//  DetailProductController.swift
//  vk-market
//
//  Created by Александр on 29.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class DetailProductController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var pictureView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var commentView: CommentView! {
        didSet {
            self.commentView.showSeparate()
        }
    }
    @IBOutlet private weak var descriptionView: UIView! {
        didSet {
            self.descriptionView.showSeparate()
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var product: Product
    private var comments: [Comment]? {
        didSet {
            self.commentView?.setComments(count: self.comments?.count ?? 0)
        }
    }
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Товар"
        self.setup(product: self.product)
        // Do any additional setup after loading the view.
    }
    
    private func setup(product: Product) {
        self.titleLabel.text = product.title
        self.priceLabel.text = product.priceString
        self.pictureView.sd_setImage(with: product.pictureURL, completed: nil)
        self.descriptionLabel.text = product.description
        self.commentView.onDidTapped = {
            self.showCommentController(product: product)
        }
        self.commentView.setLikes(count: self.product.likes?.count ?? 0)
        self.loadComments()
    }
    
    private func loadComments() {
        VKManager.shared.getComments(ownerId: product.ownerId, itemId: product.id, offset: 0) { (comments, errorString) in
            self.comments = comments
        }
    }
    
    private func showCommentController(product: Product) {
        let vc = CommentsController(ownerId: product.ownerId, itemId: product.id)
        vc.comments = self.comments ?? []
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}