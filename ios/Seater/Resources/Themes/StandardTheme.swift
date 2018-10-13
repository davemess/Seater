//
//  StandardTheme.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppTheme

/// A custom application appearance theme.
struct StandardTheme: AppearanceTheme {
    
    // Basic
    var backgroundColor: UIColor { return UIColor(named: "Background")! }
    
    // Navigation bar
    var navigationBarBarTintColor: UIColor? { return UIColor(named: "NavigationBar")! }
    var navigationBarTextAttributes: [NSAttributedString.Key: Any]? {
        return [.foregroundColor: UIColor(named: "NavigationBarText")!]
    }
    var navigationBarLargeTitleTextAttributes: [NSAttributedString.Key: Any]? {
        return [.foregroundColor: UIColor(named: "NavigationBarText")!]
    }
    var navigationBarTintColor: UIColor? { return UIColor(named: "NavigationBarTint")! }
}
