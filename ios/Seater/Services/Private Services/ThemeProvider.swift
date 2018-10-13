//
//  ThemeProvider.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppConfiguration
import AppTheme

/// Enacapsulates configuration of a theme service.
final class StandardThemeProvider: ThemeProviderService {
    
    let theme: AppearanceTheme
    
    // MARK: - lifecycle
    
    init(_ deployment: Deployment) {
        switch deployment {
        case .development:
            // Potential to experiment with different themes here
            theme = StandardTheme()
        case .staging, .production:
            theme = StandardTheme()
        }
    }
}
