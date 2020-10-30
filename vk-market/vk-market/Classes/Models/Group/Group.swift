//
//  Group.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class Group: Decodable {

    var name: String
    var id: Int
    var photo50: String
    var photo200: String
    
    enum CodingKeys: String, CodingKey {
        case name, id, photo50 = "photo_50", photo200 = "photo_200"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        photo50 = try container.decode(String.self, forKey: .photo50)
        photo200 = try container.decode(String.self, forKey: .photo200)
    }
    
}
