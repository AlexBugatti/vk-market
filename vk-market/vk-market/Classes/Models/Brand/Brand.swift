//
//  Brand.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class Brand: Decodable {

    var name: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case name, id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
}
