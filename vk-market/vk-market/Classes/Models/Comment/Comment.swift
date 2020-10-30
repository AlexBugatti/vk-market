//
//  Comment.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class CommentResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
        case profiles
    }
    
    var count: Int
    var items: [Comment] = []
    var profiles: [Profile] = []
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        if let items = try? container.decode([Comment].self, forKey: .items) {
            self.items = items
        }
        if let profiles = try? container.decode([Profile].self, forKey: .profiles) {
            self.profiles = profiles
        }
    }
    
}

class Comment: Decodable {

    var id: Int
    var fromId: Int
    var canEdit: Int
    var date: Int
    var text: String

    var profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case id, fromId = "from_id", canEdit = "can_edit", date, text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        fromId = try container.decode(Int.self, forKey: .fromId)
        canEdit = try container.decode(Int.self, forKey: .canEdit)
        date = try container.decode(Int.self, forKey: .date)
        text = try container.decode(String.self, forKey: .text)
    }
    
}

class Profile: Decodable {

    var firstName: String
    var id: Int
    var lastName: String
    var photo100: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name", id = "id", lastName = "last_name", photo100 = "photo_100"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        photo100 = try? container.decode(String.self, forKey: .photo100)
    }
    
}
