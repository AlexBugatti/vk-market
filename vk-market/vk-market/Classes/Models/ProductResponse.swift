//
//  ProductResponse.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class ProductResponse: Decodable {

    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    var count: Int
    var items: [Product] = []
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        if let items = try? container.decode([Product].self, forKey: .items) {
            self.items = items
        }
    }
    
}
