//
//  Product.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

protocol Productable {
    var title: String { get }
    var priceString: String { get }
    var pictureURL: URL? { get }
}

class Product: Decodable, Productable {
    
    var id: Int
    var ownerId: Int
    var title: String
    var description: String
    var price: Price
    var category: Category
    var date: Int?
    var thumbPhoto: String
    var availability: Int
    var isFavorite: Bool
    
    var photos: [Photo]?
    var likes: Like?
    
    var priceString: String {
        return self.price.text
    }
    var pictureURL: URL? {
        return URL(string: thumbPhoto)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, ownerId = "owner_id", title, description, price, category, date, thumbPhoto = "thumb_photo", availability, photos, likes, isFavorite = "is_favorite"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        price = try container.decode(Price.self, forKey: .price)
        category = try container.decode(Category.self, forKey: .category)
        date = try? container.decode(Int.self, forKey: .date)
        thumbPhoto = try container.decode(String.self, forKey: .thumbPhoto)
        availability = try container.decode(Int.self, forKey: .availability)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        
        photos = try? container.decode([Photo].self, forKey: .photos)
        likes = try? container.decode(Like.self, forKey: .likes)
    }
    
    class Category: Decodable {
        var id: Int
        var name: String
        var section: Section
        
        class Section: Decodable {
            var id: Int
            var name: String
        }

    }
    
}

extension Product {
    
    class Price: Decodable {
        var amount: String
        var currency: Currency
        var text: String
        
        enum CodingKeys: String, CodingKey {
            case amount, currency, text
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            amount = try container.decode(String.self, forKey: .amount)
            currency = try container.decode(Currency.self, forKey: .currency)
            text = try container.decode(String.self, forKey: .text)
        }
    }
    
}

extension Product {
    
    class Currency: Decodable {
        var id: Int
        var name: String
        
        enum CodingKeys: String, CodingKey {
            case id, name
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
        }
    }
    
}
