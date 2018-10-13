//
//  AppearanceThemeManager.swift
//  AppTheme
//
//  Created by David Messing on 10/13/18.
//

import UIKit

/// A manager for configuring application theming based on UIAppearance.
public class AppearanceThemeManager {
    
    // MARK: - public accessors
    
    public static var theme: AppearanceTheme = BasicAppearanceTheme() {
        didSet {
            apply(theme)
        }
    }
    
    // MARK: - lifecycle
    
    private init() {}
    
    // MARK: - public
    
    public static func customize(_ view: UIView) {
        let theme = self.theme
        
        view.backgroundColor = theme.backgroundColor
    }
    
    public static func customize(_ navigationBar: UINavigationBar) {
        let theme = self.theme
        
        navigationBar.setBackgroundImage(theme.navigationBarImage, for: .default)
        navigationBar.setBackgroundImage(theme.navigationBarLandscapeImage, for: .compact)
        navigationBar.titleTextAttributes = theme.navigationBarTextAttributes
        navigationBar.largeTitleTextAttributes = theme.navigationBarLargeTitleTextAttributes
        navigationBar.barTintColor = theme.navigationBarBarTintColor
        navigationBar.tintColor = theme.navigationBarTintColor
    }
    
    // MARK: - private
    
    private static func apply(_ theme: AppearanceTheme) {
        configureNavigationBar(theme)
    }
    
    private static func configureNavigationBar(_ theme: AppearanceTheme) {
        let appearance = UINavigationBar.appearance()
        
        appearance.setBackgroundImage(theme.navigationBarImage, for: .default)
        appearance.setBackgroundImage(theme.navigationBarLandscapeImage, for: .compact)
        appearance.titleTextAttributes = theme.navigationBarTextAttributes
        appearance.largeTitleTextAttributes = theme.navigationBarLargeTitleTextAttributes
        appearance.barTintColor = theme.navigationBarBarTintColor
        appearance.tintColor = theme.navigationBarTintColor
    }
}
