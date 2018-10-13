//
//  AppCoordinator.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Navigation coordinator for root application context.
class AppCoordinator: NavigationCoordinator {
    
    let navigationController: UINavigationController
    
    private let navigationCoordinatorFactory: NavigationCoordinatorFactory
    private var children: [NavigationCoordinator] = []
    
    // MARK: - lifecycle
    
    init(_ navigationController: UINavigationController, navigationCoordinatorFactory: NavigationCoordinatorFactory) {
        self.navigationController = navigationController
        self.navigationCoordinatorFactory = navigationCoordinatorFactory
    }
    
    // MARK: - NavigationCoordinator
    
    func start(_ animated: Bool) {
        // Here is where we would launch user prompts.
        // Examples:
        // - On-boarding presentation
        // - What's New
        // - Collect feedback
        startEventsCoordinator(animated)
    }
    
    // MARK: - private
    
    private func startEventsCoordinator(_ animated: Bool) {
        let coordinatorType: NavigationCoordinatorFactory.CoordinatorType = .events(navigationController)
        let coordinator = navigationCoordinatorFactory.coordinator(for: coordinatorType)
        coordinator.start(animated)
        children.append(coordinator)
    }
}
