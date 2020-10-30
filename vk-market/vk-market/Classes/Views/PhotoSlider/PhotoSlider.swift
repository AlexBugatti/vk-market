//
//  PhotoSlider.swift
//  vk-market
//
//  Created by Александр on 29.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class PhotoSlider: NibView {
    
    private var images: [String] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.register(PhotoSliderCell.self)
        }
    }
    
    func setupUI(strings: [String]) {
        self.images = strings
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension PhotoSlider: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = self.images[indexPath.row]
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PhotoSliderCell
        cell.logoView.sd_setImage(with: URL(string: image), completed: nil)
        
        return cell
    }

}
