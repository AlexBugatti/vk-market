//
//  Storage.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

class Storage {
    static var subcategories: [Subcategory] {
        if let path = Bundle.main.path(forResource: "subcategories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let subcategories = try? JSONDecoder().decode([Subcategory].self, from: data) {
                    return subcategories
                }
            } catch {}
        }
        
        return []
    }
    static var brands: [Brand] {
        if let path = Bundle.main.path(forResource: "brands", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let brands = try? JSONDecoder().decode([Brand].self, from: data) {
                    return brands
                }
            } catch {}
        }
        
        return []
    }
}
