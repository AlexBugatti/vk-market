//
//  AlbumView.swift
//  vk-market
//
//  Created by Александр on 31.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class AlbumView: UICollectionReusableView {

    var didAlbumTapped: ((Album)->())?
    
    private var albums: [Album] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 200),
                                               collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCell.self)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        
        return collectionView
    }()
    
    func setAlbums(_ albums: [Album]) {
        self.albums = albums
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myCustomInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.myCustomInit()
    }

    func myCustomInit() {
        self.addSubview(self.collectionView)
        let consts = [self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                      self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                      self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
                      self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
        NSLayoutConstraint.activate(consts)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension AlbumView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as AlbumCell
        let album = self.albums[indexPath.row]
        cell.configure(album)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        return CGSize(width: width, height: width * Constants.imageRatio + 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = self.albums[indexPath.row]
        self.didAlbumTapped?(album)
        
    }
    
    
}
