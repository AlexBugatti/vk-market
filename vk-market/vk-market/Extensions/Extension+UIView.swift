//
//  Extension+UIView.swift
//  vk-market
//
//  Created by Александр on 28.10.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }
protocol ReusableView: class {}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: NibLoadableView { }
extension UITableViewCell: ReusableView { }

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionViewCell: NibLoadableView { }
extension UICollectionViewCell: ReusableView { }

extension UIView {
    
    class func createSeparateView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Pallete.separateColor
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return view
    }
    
    func showSeparate() {
        let separateView = UIView.createSeparateView()
        self.addSubview(separateView)
        
        let constraints = [self.leadingAnchor.constraint(equalTo: separateView.leadingAnchor, constant: -12),
                           self.trailingAnchor.constraint(equalTo: separateView.trailingAnchor, constant: 12),
                           self.topAnchor.constraint(equalTo: separateView.topAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
}

class NibView: UIView {
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view from .xib file
        xibSetup()
    }
    
}
private extension NibView {
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        self.clipsToBounds = view.clipsToBounds
        self.layer.cornerRadius = view.layer.cornerRadius
        // Adding custom subview on top of our view
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
