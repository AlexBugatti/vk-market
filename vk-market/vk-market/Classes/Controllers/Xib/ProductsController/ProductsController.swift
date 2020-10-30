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
    private var group: Group
    
    init(group: Group) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadProducts()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationItem.title = self.group.name
        self.navigationController?.navigationBar.showSeparateView()
        
        self.collectionView.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func loadProducts() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        VKManager.shared.getDocuments(ownerId: -self.group.id, offset: 0) { (products, errorString) in
            hud.hide(animated: true)
            self.products = products ?? []
            print(products ?? "")
        }
    }
    
    private func showProduct(product: Product) {
        let vc = DetailProductController(product: product)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        cell.setupUI(item: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.showProduct(product: product)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 36) / 2
        let height = width + 64
        
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}
