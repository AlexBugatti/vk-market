//
//  Pallete.swift
//  vk-market
//
//  Created by Александр on 27.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class Pallete {

    static let main = #colorLiteral(red: 0.2848604023, green: 0.5270966291, blue: 0.7986255288, alpha: 1)
    static let subtitle = #colorLiteral(red: 0.5055235028, green: 0.5491905212, blue: 0.6000059843, alpha: 1)
    
    static let textfieldBackground = #colorLiteral(red: 0.9498776793, green: 0.9532684684, blue: 0.9594311118, alpha: 1)
    static let textfieldBorderColor = #colorLiteral(red: 0.7843145728, green: 0.7879097462, blue: 0.7944523692, alpha: 1)
    
    static let separateColor = #colorLiteral(red: 0.8438933492, green: 0.8473063111, blue: 0.8505352736, alpha: 1)
    
    static let blue = #colorLiteral(red: 0.354600966, green: 0.6055220962, blue: 0.8935770988, alpha: 1)
    static let red = #colorLiteral(red: 0.9369511008, green: 0.3555267155, blue: 0.2664669752, alpha: 1)
    static let orange = #colorLiteral(red: 0.9974765182, green: 0.6292669773, blue: 0.002666248009, alpha: 1)
    static let gray = #colorLiteral(red: 0.4862369895, green: 0.536072135, blue: 0.6361938715, alpha: 1)
    static let violet = #colorLiteral(red: 0.6694304347, green: 0.4581828117, blue: 0.8772745132, alpha: 1)
    
    class func color(_ string: String) -> UIColor {
        switch string {
            case "blue": return Pallete.blue
            case "red": return Pallete.red
            case "orange": return Pallete.orange
            case "gray": return Pallete.gray
            case "violet": return Pallete.violet
            default: return Pallete.blue
        }
    }
    
}
