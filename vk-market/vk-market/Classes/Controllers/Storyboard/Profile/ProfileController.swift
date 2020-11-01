//
//  ProfileController.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileController: UIViewController {

    private var products: [Product] = [] {
        didSet {
            self.collectionView?.reloadData()
            self.descriptionLabel.text = "\(self.products.count) товара в избранном"
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var logoView: UIImageView! {
        didSet {
            self.logoView.layer.cornerRadius = self.logoView.frame.height / 2
            self.logoView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadFavorites()
        loadUser()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.showSeparateView()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ProductCollectionCell.self)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: Constants.defaultPadding, bottom: 0, right: 0)
        self.collectionView.showSeparate()

    }
    
    private func loadUser() {
        VKManager.shared.getUserInfo { (user, errorString) in
            if let user = user {
                self.setupUI(user)
            }
        }
    }
    
    private func loadFavorites() {
        VKManager.shared.getFavoriteProducts { (products, errorString) in
            self.products = products
        }
    }
    
    private func setupUI(_ user: User) {
        self.navigationItem.title = "id\(user.id)"
        self.titleLabel.text = "\(user.firstName) \(user.lastName)"
        self.logoView.sd_setImage(with: URL(string: user.photo200), completed: nil)
    }
    
    private func showProduct(product: Product) {
        let vc = DetailProductController(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARL: - Actions
    
    @IBAction func onDidLogoutTapped(_ sender: Any) {
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

extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ProductCollectionCell
        cell.setupUI(item: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.showProduct(product: product)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.products.count == 1 {
            let width = (self.view.frame.width - Constants.defaultPadding) / 2
            let height = width + 64
            
            return CGSize(width: self.view.frame.width - Constants.defaultPadding, height: height)
        }
        
        let width = (self.view.frame.width - Constants.defaultPadding) / 2
        let height = width + 64
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
