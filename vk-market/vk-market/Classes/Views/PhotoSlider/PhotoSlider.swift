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
            self.collectionView.isUserInteractionEnabled = true
            self.collectionView.isPagingEnabled = true
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    
    func setupUI(strings: [String]) {
        self.images = strings
        self.pageControl.numberOfPages = strings.count
        
        strings.forEach { (imagePath) in
            UIImageView().sd_setImage(with: URL(string: imagePath), completed: nil)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension PhotoSlider: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = self.images[indexPath.row]
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PhotoSliderCell
        cell.logoView.sd_setImage(with: URL(string: image), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}
