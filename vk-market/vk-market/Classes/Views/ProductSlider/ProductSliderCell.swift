//
//  ProductSliderCell.swift
//  vk-market
//
//  Created by Александр on 01.11.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class ProductSliderCell: UICollectionViewCell {

    var didProductTapped: ((Product)->())?
    
    private var products: [Product] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.register(AlbumProductCell.self)
            self.collectionView.contentInset = UIEdgeInsets(top: 16, left: Constants.defaultPadding, bottom: 0, right: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ list: ProductList) {
        self.products = list.products
        self.titleLabel.text = list.title
    }

}

extension ProductSliderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as AlbumProductCell
        cell.setupUI(item: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.didProductTapped?(product)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.frame.height
        let width = height - 80
        
        return CGSize(width: 135, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
