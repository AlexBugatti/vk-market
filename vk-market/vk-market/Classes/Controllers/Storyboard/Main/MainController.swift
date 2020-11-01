//
//  MainController.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var productList: [ProductList] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Главная"
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
        self.navigationItem.title = "Главная"
        self.navigationController?.navigationBar.showSeparateView()
        
        self.collectionView.register(ProductSliderCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset.top = 12
    }
    
    private func loadProducts() {
        ProductManager.getDownloadProductList(list: [ProductList.cross, ProductList.winter]) { (productList) in
            self.productList = productList
        }
    }
    
    private func showDetailController(_ product: Product) {
        let vc = DetailProductController(product: product)
        vc.hidesBottomBarWhenPushed = true
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

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let list = self.productList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ProductSliderCell
        cell.configure(list)
        cell.didProductTapped = { product in
            self.showDetailController(product)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.view.frame.width, height: 217)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let product = self.products[indexPath.row]
//        self.showProduct(product: product)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
