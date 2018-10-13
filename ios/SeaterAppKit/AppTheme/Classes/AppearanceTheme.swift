//
//  AppearanceTheme.swift
//  AppTheme
//
//  Created by David Messing on 10/13/18.
//

import UIKit

/// Describes a base protocol for UIAppearance themeing.
public protocol AppearanceTheme {
    
    // Basic
    var backgroundColor: UIColor { get }
    
    // Navigation bar
    var navigationBarImage: UIImage? { get }
    var navigationBarLandscapeImage: UIImage? { get }
    var navigationBarTextAttributes: [NSAttributedString.Key: Any]? { get }
    var navigationBarLargeTitleTextAttributes: [NSAttributedString.Key: Any]? { get }
    var navigationBarBarTintColor: UIColor? { get }
    var navigationBarTintColor: UIColor? { get }
}

/// Initial base themimg. Defaults to standard UIKit appearances.
public extension AppearanceTheme {
    
    // Basic
    var backgroundColor: UIColor { return UIColor.white }
    
    // Navigation bar
    var navigationBarImage: UIImage? { return nil }
    var navigationBarLandscapeImage: UIImage? { return nil }
    var navigationBarTextAttributes: [NSAttributedString.Key: Any]? { return nil }
    var navigationBarLargeTitleTextAttributes: [NSAttributedString.Key: Any]? { return nil }
    var navigationBarBarTintColor: UIColor? { return nil }
    var navigationBarTintColor: UIColor? { return nil }
}

/// Basic themimg which allows concrete instantiation of the default AppearanceTheme. Defaults to standard UIKit appearances.
public struct BasicAppearanceTheme: AppearanceTheme {
    
    public init() {
        // empty implemenation
        // defaults are derived from the default extension on AppearanceTheme
    }
}
