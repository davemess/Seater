//
//  ServiceProvider.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Describes a type which can supply services.
protocol ServiceProvider {
    var services: [Service] { get }
    var analyticsService: AnalyticsService { get }
    var themeProvider: ThemeProviderService { get }
}

extension ServiceProvider {
    
    var services: [Service] {
        return [
            analyticsService,
            themeProvider
        ]
    }
}
