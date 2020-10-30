//
//  Like.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

class Like: Decodable {
    var userLikes: Int
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count, userLikes = "user_likes"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        userLikes = try container.decode(Int.self, forKey: .userLikes)
    }
}
