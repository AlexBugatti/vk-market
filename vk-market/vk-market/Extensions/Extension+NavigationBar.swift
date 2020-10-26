//
//  Extension+NavigationBar.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

//@objc protocol Separated: class {
//    var separator: UIView { get set }
//    var isSeparatorHidden: Bool { get set }
//}
//
//extension Separated where Self: UINavigationBar {
//
//
//}

extension UINavigationBar {

    func showSeparateView() {
        
        self.subviews.forEach { (view) in
            if view.tag == 234 {
                return
            }
        }
        
        let separateView = UIView()
        separateView.backgroundColor = #colorLiteral(red: 0.8438933492, green: 0.8473063111, blue: 0.8505352736, alpha: 1)
        separateView.tag = 234
        separateView.translatesAutoresizingMaskIntoConstraints = false
        separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        self.addSubview(separateView)
        let constraints = [self.bottomAnchor.constraint(equalTo: separateView.bottomAnchor),
                           separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
                           self.trailingAnchor.constraint(equalTo: separateView.trailingAnchor, constant: 12)
                        ]
        NSLayoutConstraint.activate(constraints)
        self.layoutIfNeeded()
    }

    func hideSeparateView() {
        self.subviews.filter({ $0.tag == 234 }).forEach({ $0.removeFromSuperview() })
    }

}
