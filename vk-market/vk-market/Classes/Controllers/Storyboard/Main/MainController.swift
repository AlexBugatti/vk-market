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
    private var products: [Product] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
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
        
        self.collectionView.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func loadProducts() {
        VKManager.shared.getDocuments(ownerId: -13643401, offset: 0) { (products, errorString) in
            self.products = products ?? []
            print(products ?? "")
        }
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
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        cell.setupUI(item: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 36) / 2
        let height = width + 60
        
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
