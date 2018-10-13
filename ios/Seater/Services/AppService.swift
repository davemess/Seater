//
//  AppService.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AppConfiguration
import AppAnalytics
import AppTheme

/// Identifies an configurable service required by the app.
protocol AppService {
    init(_ deployment: Deployment)
}

/// Identifies a service that is expected to be started during application launch.
protocol LaunchService: AppService {
    func initialize(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

// MARK: - Service Defintions

/// Describes a service which can supply an analytics recorder.
protocol AnalyticsService: AppService {
    func analyticsRecorder() -> AnalyticsRecorder
}

/// Describes a service which supply an appearance theme.
protocol ThemeProviderService: AppService {
    var theme: AppearanceTheme { get }
}
