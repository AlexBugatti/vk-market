//
//  Subcategory.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class Subcategory: Decodable {

    var name: String
    var id: Int
    var imageName: String
    var imageColor: String
    
    enum CodingKeys: String, CodingKey {
        case name, id, imageName, imageColor
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageName = try container.decode(String.self, forKey: .imageName)
        imageColor = try container.decode(String.self, forKey: .imageColor)
    }
    
}
