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
    
    // MARK: - properties
    
    lazy var services: [Service] = {
        let deployment = self.buildConfiguration.deployment
        
        // Add third-party services which are required for application lifecycle
        return [
            CrashlyticsService(deployment)
        ]
    }()
    
    private var buildConfiguration: BuildConfiguration
    
    // MARK: - lifecycle
    
    init(_ buildConfiguration: BuildConfiguration) {
        self.buildConfiguration = buildConfiguration
    }
}
