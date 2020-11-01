//
//  VKFavoriteModule.swift
//  vk-market
//
//  Created by Александр on 31.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

import VK_ios_sdk

extension VKManager {

    func getFavoriteProducts(completion: @escaping ([Product], String?)->()) {
        let parameters = ["v": "5.124",
                          "item_type": "product"]
        
        let request = VKRequest(method: "fave.get", parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let faveProducts = try? JSONDecoder().decode(FavoriteProductResponse.self, from: jsonData) else {
                completion([], "Некорректный ответ")
                return
            }
            
            completion(faveProducts.items.map({ $0.product }), nil)
            
        }, errorBlock: { (error) in
            completion([], error?.localizedDescription)
        })
    }
    
    func addFavoriteProduct(ownerId: Int, id: Int, completion: @escaping (Bool, String?)->()) {
        let parameters = ["owner_id": ownerId,
                          "id": id]
        
        let request = VKRequest(method: "fave.addProduct", parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json else {
                completion(false, "Некорректный ответ")
                return
            }
            
            let value = json as! NSNumber
            return completion(value.boolValue, nil)
            
        }, errorBlock: { (error) in
            completion(false, error?.localizedDescription)
        })
    }
    
    func removeFavoriteProduct(ownerId: Int, id: Int, completion: @escaping (Bool, String?)->()) {
        let parameters = ["owner_id": ownerId,
                          "id": id]
        
        let request = VKRequest(method: "fave.removeProduct", parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json else {
                completion(false, "Некорректный ответ")
                return
            }
            
            let value = json as! NSNumber
            return completion(value.boolValue, nil)
            
        }, errorBlock: { (error) in
            completion(false, error?.localizedDescription)
        })
    }

}
