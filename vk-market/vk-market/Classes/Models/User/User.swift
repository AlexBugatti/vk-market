//
//  User.swift
//  vk-market
//
//  Created by Александр on 31.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

class User: Decodable {
    
    var id: Int
    var firstName: String //: -13643401,
    var lastName: String //"Outdoor",
    var photo200: String // 12,
    
    enum CodingKeys: String, CodingKey {
        case id, firstName = "first_name", lastName = "last_name", photo200 = "photo_200"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        photo200 = try container.decode(String.self, forKey: .photo200)
    }
    
}

