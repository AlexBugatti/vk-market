//
//  VKGroupsModule.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation
import VK_ios_sdk

extension VKManager {
     
    func getGroups(categoryId: Int, subcategoryId: Int, completion: @escaping ([Group]?, String?)->()) {
        let parameters = ["category_id": categoryId,
                          "subcategory_id": subcategoryId]
        
        let request = VKRequest(method: "groups.getCatalog", parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let docResponse = try? JSONDecoder().decode(GroupResponse.self, from: jsonData) else {
                completion([], "Некорректный ответ")
                return
            }
            
            completion(docResponse.items, nil)
            
        }, errorBlock: { (error) in
            completion(nil, error?.localizedDescription)
        })
    }
    
}
