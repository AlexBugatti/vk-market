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
     
    func getDocuments(ownerId: Int, offset: Int, completion: @escaping ([Product]?, String?)->()) {
        let parameters = ["v": "5.124",
                          "owner_id": ownerId,
                          "extended": 1] as [String : Any]
        
        let request = VKRequest(method: "market.get", parameters: parameters)
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
    
}
