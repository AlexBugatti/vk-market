//
//  ProductsController.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProductsController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var products: [Product] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    private var requestParameters: ProductParameterRequestable
    private var albums: [Album] = []
    
    init(requestParameters: ProductParameterRequestable) {
        self.requestParameters = requestParameters
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

        setupUI()
        loadProducts()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationItem.title = self.requestParameters.title
        self.navigationController?.navigationBar.showSeparateView()
        
        self.collectionView.register(ProductCollectionCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets(top: 8, left: Constants.defaultPadding, bottom: 0, right: 0)
        self.collectionView.register(AlbumView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    private func loadProducts() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        VKManager.shared.getProducts(ownerId: self.requestParameters.ownerId, albumId: self.requestParameters.albumId) { (products, errorString) in
            hud.hide(animated: true)
            self.products = products ?? []
            if self.requestParameters.albumId == 0 {
                self.loadAlbums()
            }
            print(products ?? "")
        }
    }
    
    private func loadAlbums() {
        VKManager.shared.getAlbums(ownerId: self.requestParameters.ownerId) { (albums, errorString) in
            if let albums = albums, albums.count > 0 {
                self.albums = albums
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showProduct(product: Product) {
        let vc = DetailProductController(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showProducts(requestParameters: ProductParameterRequestable) {
        let vc = ProductsController(requestParameters: requestParameters)
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

extension ProductsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                
        let width = (self.view.frame.width - Constants.defaultPadding) / 2
        let height = width + 54
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind.isEqual(UICollectionView.elementKindSectionHeader) {
            let albumHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! AlbumView
            albumHeaderView.didAlbumTapped = { album in
                self.showProducts(requestParameters: album)
            }
            albumHeaderView.setAlbums(self.albums)
            return albumHeaderView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if self.albums.count == 0 {
            return CGSize.zero
        }
        
        return CGSize(width: self.view.frame.width,
                      height: self.view.frame.width * Constants.imageRatio + 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
