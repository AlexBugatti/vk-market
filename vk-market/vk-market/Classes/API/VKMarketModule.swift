//
//  VKMarketModule.swift
//  vk-market
//
//  Created by Александр on 26.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation
import VK_ios_sdk

extension VKManager {
    
    enum Market: String {
        case get = "market.get"
        case getById = "market.getById"
        case getComments = "market.getComments"
        case getAlbums = "market.getAlbums"
    }
    
    func getProducts(ownerId: Int, albumId: Int = 0, offset: Int = 0, completion: @escaping ([Product]?, String?)->()) {
        let parameters = ["v": "5.124",
                          "owner_id": ownerId,
                          "offset": offset,
                          "album_id": albumId,
                          "extended": 1] as [String : Any]
        
        let request = VKRequest(method: Market.get.rawValue, parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let docResponse = try? JSONDecoder().decode(ProductResponse.self, from: jsonData) else {
                completion([], "Некорректный ответ")
                return
            }
            
            completion(docResponse.items, nil)
            
        }, errorBlock: { (error) in
            completion(nil, error?.localizedDescription)
        })
    }
    
    func getProductsBy(itemIds: [String], offset: Int = 0, completion: @escaping ([Product]?, String?)->()) {
        let parameters = ["v": "5.124",
                          "item_ids": itemIds.joined(separator: ","),
                          "extended": 1] as [String : Any]
        
        let request = VKRequest(method: Market.getById.rawValue, parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let docResponse = try? JSONDecoder().decode(ProductResponse.self, from: jsonData) else {
                completion([], "Некорректный ответ")
                return
            }
            
            completion(docResponse.items, nil)
            
        }, errorBlock: { (error) in
            completion(nil, error?.localizedDescription)
        })
    }
    
    func getComments(ownerId: Int, itemId: Int, offset: Int? = 0, completion: @escaping ([Comment]?, String?)->()) {
        let parameters = ["v": "5.124",
                          "owner_id": ownerId,
                          "item_id": itemId,
                          "fields": "sex,photo_100",
                          "extended": 1] as [String : Any]
        
        let request = VKRequest(method: "market.getComments", parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let docResponse = try? JSONDecoder().decode(CommentResponse.self, from: jsonData) else {
                completion([], "Некорректный ответ")
                return
            }
            
            docResponse.items.forEach { (comment) in
                if let profile = docResponse.profiles.first(where: { $0.id == comment.fromId }) {
                    comment.profile = profile
                }
            }
            completion(docResponse.items, nil)
            
        }, errorBlock: { (error) in
            completion(nil, error?.localizedDescription)
        })
    }
    
    func getAlbums(ownerId: Int, offset: Int? = 0, count: Int? = 100, completion: @escaping ([Album]?, String?)->()) {
        let parameters = ["v": "5.124",
                          "owner_id": ownerId] as [String : Any]
        
        let request = VKRequest(method: Market.getAlbums.rawValue, parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let responseObject = try? JSONDecoder().decode(AlbumResponse.self, from: jsonData) else {
                completion([], "Некорректный ответ")
                return
            }
            
            completion(responseObject.items, nil)
            
        }, errorBlock: { (error) in
            completion(nil, error?.localizedDescription)
        })
    }
    
}
