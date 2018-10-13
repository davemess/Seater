//
//  AppServiceProvider.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Describes a type which can supply services.
protocol AppServiceProvider {
    var services: [AppService] { get }
    var analyticsService: AnalyticsService { get }
    var themeProvider: ThemeProviderService { get }
}

extension AppServiceProvider {
    
    var services: [AppService] {
        return [
            analyticsService,
            themeProvider
        ]
    }
}
