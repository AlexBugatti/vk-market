//
//  ProductList.swift
//  vk-market
//
//  Created by Александр on 01.11.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class ProductList {
    var title: String
    var productIds: [String]
    var products: [Product] = []
    
    init(title: String, productIds: [String]) {
        self.title = title
        self.productIds = productIds
    }
    
    static var cross: ProductList {
        return ProductList.init(title: "Осень. Кроссы", productIds: ["-13643401_3435117",
                                                                "-13643401_3421155",
                                                                "-48067211_4232524",
                                                                "-48067211_4330907",
                                                                "-18072583_4765518",
                                                                "-18072583_4723997"])
    }
    
    static var winter: ProductList {
        return ProductList.init(title: "Зима 2020-2021", productIds: ["-13643401_4047970",
                                                                "-13643401_4047978",
                                                                "-13643401_3960368",
                                                                "-13643401_3883190",
                                                                "-13643401_3960361"])
    }
}

class ProductManager {
    
    class func getDownloadProductList(list: [ProductList], completion: @escaping ([ProductList])->()) {
        
        let downloadGroup = DispatchGroup()
        
        let _ = DispatchQueue.global(qos: .userInitiated)
        DispatchQueue.concurrentPerform(iterations: list.count) { (index) in
            let productList = list[index]
            downloadGroup.enter()
            
            VKManager.shared.getProductsBy(itemIds: productList.productIds) { (products, errorString) in
                productList.products = products ?? []
                downloadGroup.leave()
            }
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
            completion(list)
        }
    }
}
