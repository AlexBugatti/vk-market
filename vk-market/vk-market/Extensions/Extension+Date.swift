//
//  Extension+Date.swift
//  vk-market
//
//  Created by Александр on 30.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

extension Date {
    
    func format(string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = string
        
        return formatter.string(from: self)
    }
    
}
