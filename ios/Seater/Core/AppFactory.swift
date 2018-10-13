//
//  AppFactory.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AppAnalytics
import AppTheme

/// Core factory for producing components necessary for app launch and run.
class AppFactory {

    // MARK: - private properties
    
    private let appServiceProvider: AppServiceProvider
    
    private lazy var viewControllerFactory: ViewControllerFactory = {
        return ViewControllerFactory()
    }()
    
    // MARK: - public properties
    
    var launchServices: [LaunchService] {
        var launchServices: [LaunchService] = []
        for service in appServiceProvider.services {
            if let launchService = service as? LaunchService {
                launchServices.append(launchService)
            }
        }
        return launchServices
    }
    
    lazy var analyticsRecorder: AnalyticsRecorder = {
        let service = self.appServiceProvider.analyticsService
        return service.analyticsRecorder()
    }()
    
    lazy var applicationTheme: AppearanceTheme = {
        let service = self.appServiceProvider.themeProvider
        return service.theme
    }()
    
    // MARK: - lifecyle
    
    init(_ appServiceProvider: AppServiceProvider) {
        self.appServiceProvider = appServiceProvider
    }
    
    // MARK: - public funcs
    
    func rootCoordinator(with navigationController: UINavigationController) -> NavigationCoordinator {
        let navCoordinatorFactory = navigationCoordinatorFactory()
        return AppCoordinator(navigationController, navigationCoordinatorFactory: navCoordinatorFactory)
    }
    
    // MARK: - private funcs
    
    private func navigationCoordinatorFactory() -> NavigationCoordinatorFactory {
        return NavigationCoordinatorFactory(viewControllerFactory)
    }
}
