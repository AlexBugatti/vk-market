//
//  VKUserModule.swift
//  vk-market
//
//  Created by Александр on 31.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import VK_ios_sdk

extension VKManager {

    func getUserInfo(completion: @escaping (User?, String?)->()) {
        let parameters = ["fields": "photo_200"]
        
        let request = VKRequest(method: "users.get", parameters: parameters)
        request?.execute(resultBlock: { (response) in
            //
            guard let response = response, let json = response.json, let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), let users = try? JSONDecoder().decode([User].self, from: jsonData) else {
                completion(nil, "Некорректный ответ")
                return
            }
            
            completion(users.first, nil)
            
        }, errorBlock: { (error) in
            completion(nil, error?.localizedDescription)
        })
    }

}
