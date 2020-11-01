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
    @IBOutlet private weak var photoSlider: PhotoSlider!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var actionButton: MainButton!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Товар"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.photoSlider.setupUI(strings: self.product.photos?.compactMap({ $0.photoURL }) ?? [product.pictureURL!.absoluteString])
        let image = product.isFavorite ? #imageLiteral(resourceName: "star-active") : #imageLiteral(resourceName: "star")
        self.favoriteButton.setImage(image, for: .normal)
        if let buttonTitle = product.buttonTitle {
            self.actionButton.setTitle(buttonTitle, for: .normal)
        }
        self.loadComments()
    }
    
    private func loadComments() {
        VKManager.shared.getComments(ownerId: product.ownerId, itemId: product.id, offset: 0) { (comments, errorString) in
            self.comments = comments
        }
    }
    
    private func addFavorite() {
        self.favoriteButton.setImage(#imageLiteral(resourceName: "star-active"), for: .normal)
        VKManager.shared.addFavoriteProduct(ownerId: product.ownerId, id: product.id) { (success, errorString) in
            self.product.isFavorite = success
            self.setup(product: self.product)
        }
    }
    
    private func removeFavorite() {
        self.favoriteButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        VKManager.shared.addFavoriteProduct(ownerId: product.ownerId, id: product.id) { (success, errorString) in
            self.product.isFavorite = !success
            self.setup(product: self.product)
        }
    }
    
    private func showCommentController(product: Product) {
        let vc = CommentsController(ownerId: product.ownerId, itemId: product.id)
        vc.comments = self.comments ?? []
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func onDidFavoriteTapped(_ sender: Any) {
        if self.product.isFavorite {
            self.removeFavorite()
        } else {
            self.addFavorite()
        }
    }
    
    @IBAction func onDidActionTapped(_ sender: Any) {
        var productURL: URL!
        if let urlString = product.url, let url = URL(string: urlString) {
            productURL = url
        } else {
            let urlPath = "https://vk.com/market-\(self.product.ownerId)?w=prouduct-\(product.ownerId)_\(product.id)"
            productURL = URL.init(string: urlPath)
        }
        UIApplication.shared.open(productURL, options: [:], completionHandler: nil)
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
