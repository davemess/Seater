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
class AppServices {
    
    // MARK: - public properties
    
    var services: [Service] {
        // Add third-party services which are required for application lifecycle
        return [
           analyticsService
        ]
    }
    
    lazy var analyticsService: AnalyticsService = {
        return CrashlyticsService(deployment)
    }()
    
    // MARK: - private properties
    
    private let deployment: Deployment
    
    // MARK: - lifecycle
    
    init(_ buildConfiguration: BuildConfiguration) {
        self.deployment = buildConfiguration.deployment
    }
}
