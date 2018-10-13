//
//  AppServices.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppConfiguration
import SeaterKit
import SeatGeekSDK

/// Core class for providing and configuring external services.
class AppServices: AppServiceProvider, SeaterKitServiceProvider {
    
    // MARK: - public properties
    
    lazy var analyticsService: AnalyticsService = {
        return CrashlyticsService(deployment)
    }()
    
    lazy var themeProvider: ThemeProviderService = {
        return StandardThemeProvider(deployment)
    }()
    
    lazy var eventsService: EventsService = {
        return seatGeek.eventsService
    }()
    
    // MARK: - private properties
    
    private let deployment: Deployment
    
    private lazy var seatGeek: SeatGeekSDK = {
        let keys = Keys.keySet(for: deployment)
        return SeatGeekSDK(with: keys.seatGeekClientId)
    }()
    
    // MARK: - lifecycle
    
    init(_ buildConfiguration: BuildConfiguration) {
        self.deployment = buildConfiguration.deployment
    }
}
