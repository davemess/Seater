//
//  ReusableCell.swift
//  AppUI
//
//  Created by David Messing on 10/13/18.
//

import UIKit

// swiftlint:disable force_cast

/// http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/
public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
    static var nib: UINib? { return nil }
}

public extension ReusableCell where Self: NibProviding {
    
    static var nib: UINib? { return providedNib }
}

public extension UITableView {
    
    public func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: ReusableCell {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
}

public extension UICollectionView {
    
    public func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func registerReusableSupplementaryView<T: ReusableCell>(_ elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ elementKind: String, indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
