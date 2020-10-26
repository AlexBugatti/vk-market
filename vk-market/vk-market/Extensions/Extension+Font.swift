//
//  Extension+Font.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum SFProType: String {
        case regular = "SFProDisplay-Regular"
        case medium = "SFProDisplay-Medium"
        case semibold = "SFProDisplay-Semibold"
    }
    
    class func getSFProFont(type: SFProType, size: CGFloat) -> UIFont {
        
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func getSFProMediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: SFProType.medium.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
}

extension UIFont {
    
    enum TTCommonsType: String {
        case demibold = "TTCommons-DemiBold"
    }
    
    class func getTTCommonsFont(type: TTCommonsType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
