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
import SeaterKit

/// Core factory for producing components necessary for app launch and run.
class AppFactory {
    
    typealias SeaterServiceProvider = (ServiceProvider & SeaterKitServiceProvider)

    // MARK: - private properties
    
    private let serviceProvider: SeaterServiceProvider
    
    private lazy var viewControllerFactory: ViewControllerFactory = {
        return ViewControllerFactory()
    }()
    
    // MARK: - public properties
    
    var launchServices: [LaunchService] {
        var launchServices: [LaunchService] = []
        for service in serviceProvider.services {
            if let launchService = service as? LaunchService {
                launchServices.append(launchService)
            }
        }
        return launchServices
    }
    
    lazy var analyticsRecorder: AnalyticsRecorder = {
        let service = self.serviceProvider.analyticsService
        return service.analyticsRecorder()
    }()
    
    lazy var applicationTheme: AppearanceTheme = {
        let service = self.serviceProvider.themeProvider
        return service.theme
    }()
    
    var seaterKitServiceProvider: SeaterKitServiceProvider { return serviceProvider }
    
    // MARK: - lifecyle
    
    init(_ serviceProvider: SeaterServiceProvider) {
        self.serviceProvider = serviceProvider
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
