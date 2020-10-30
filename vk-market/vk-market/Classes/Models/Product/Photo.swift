//
//  Photo.swift
//  vk-market
//
//  Created by Александр on 29.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import CoreLocation

class PhotoResponse: Decodable {
    var count: Int
    var items: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        items = try container.decode([Photo].self, forKey: .items)
    }
}

class Photo: Decodable {

    var id: Int64 //integer    идентификатор фотографии.
    var albumId: Int64 //integer    идентификатор альбома, в котором находится фотография.
    var ownerId: Int64 //integer    идентификатор владельца фотографии.
    var userId: Int64? //integer    идентификатор пользователя, загрузившего фото (если фотография размещена в сообществе). Для фотографий, размещенных от имени сообщества, user_id = 100.
    var text: String //string    текст описания фотографии.
    var date: Int64  //integer    дата добавления в формате Unixtime.
    var coordinate: CLLocationCoordinate2D?
    var sizes: [Size]? //array    массив с копиями изображения в разных размерах. Каждый объект массива содержит следующие поля:
    var photoPath: String
    var photoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case userId = "user_id"
        case text
        case date
        case sizes
        case lat, long
        case photo_75
        case photo_604
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        albumId = try container.decode(Int64.self, forKey: .albumId)
        ownerId = try container.decode(Int64.self, forKey: .ownerId)
        userId = try? container.decode(Int64.self, forKey: .userId)
        text = try container.decode(String.self, forKey: .text)
        date = try container.decode(Int64.self, forKey: .date)
        sizes = try container.decode([Size].self, forKey: .sizes)
        photoPath = try container.decode(String.self, forKey: .photo_75)
        photoURL = try? container.decode(String.self, forKey: .photo_604)
        
        if let latString = try? container.decode(Double.self, forKey: .lat), let longString = try? container.decode(Double.self, forKey: .long) {
            self.coordinate = CLLocationCoordinate2D(latitude: latString,
                                                     longitude: longString)
        }
    }
    
}

//class Preview: Decodable {
//    var photo: Photo
//
//    enum CodingKeys: String, CodingKey {
//        case photo
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        photo = try container.decode(Photo.self, forKey: .photo)
//    }
//}

//class Photo: Decodable {
//    var sizes: [Size]
//
//    enum CodingKeys: String, CodingKey {
//        case sizes
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        sizes = try container.decode([Size].self, forKey: .sizes)
//    }
//}

class Size: Decodable {
    var url: String // "https://pp.vk.me/...-3/m_9d9323a080.jpg",
    var width: Int //130,
    var height: Int //98,
    var type: String //"m"
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        type = try container.decode(String.self, forKey: .type)
    }
}

