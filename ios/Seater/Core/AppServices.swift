//
//  AppServices.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppConfiguration

/// Core class for providing and configuring external services.
class AppServices: AppServiceProvider {
    
    // MARK: - public properties
    
    lazy var analyticsService: AnalyticsService = {
        return CrashlyticsService(deployment)
    }()
    
    lazy var themeProvider: ThemeProviderService = {
        return StandardThemeProvider(deployment)
    }()
    
    // MARK: - private properties
    
    private let deployment: Deployment
    
    // MARK: - lifecycle
    
    init(_ buildConfiguration: BuildConfiguration) {
        self.deployment = buildConfiguration.deployment
    }
}
