//
//  Album.swift
//  vk-market
//
//  Created by Александр on 31.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

//class Response: Decodable {
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case items
//    }
//
//    var count: Int = 0
//}

class AlbumResponse: Decodable {
    
    var items: [Album] = []
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        if let items = try? container.decode([Album].self, forKey: .items) {
            self.items = items
        }
    }
    
}

class Album: Decodable, ProductParameterRequestable {
    
    var albumId: Int {
        return id
    }
    
    var id: Int
    var ownerId: Int //: -13643401,
    var title: String //"Outdoor",
    var count: Int // 12,
    var updatedTime: Int //": 1603375713,
    var photo: Photo?
    
    enum CodingKeys: String, CodingKey {
        case id, ownerId = "owner_id", title, count, uodatedTime = "updated_time", photo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        title = try container.decode(String.self, forKey: .title)
        count = try container.decode(Int.self, forKey: .count)
        updatedTime = try container.decode(Int.self, forKey: .uodatedTime)
        photo = try? container.decode(Photo.self, forKey: .photo)
    }
    
}
