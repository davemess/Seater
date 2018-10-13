//
//  NibAssociated.swift
//  AppUI
//
//  Created by David Messing on 10/13/18.
//

import UIKit

// swiftlint:disable force_cast

/// Defines a protocol for providing nibs.
public protocol NibProviding {
    static var providedNib: UINib { get }
}

public extension NibProviding {
    
    static var providedNib: UINib {
        let nibName = String(describing: Self.self)
        let bundle = Bundle.main
        
        return UINib(nibName: nibName, bundle: bundle)
    }
}

/// Defines a protocol for loading from a nib.
public protocol NibLoading {
    static func loadFromNib() -> Self
}

public extension NibLoading where Self: UIView {
    
    static func loadFromNib() -> Self {
        let nibName = String(describing: Self.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
