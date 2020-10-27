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
        let parameters = ["owner_id": ownerId]
        
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
    
}
