//
//  NavigationCoordinatorFactory.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Factory for producing navigation coordinators.
class NavigationCoordinatorFactory {
    
    enum CoordinatorType {
        case events(_ navigationController: UINavigationController)
    }
    
    // MARK: - lifecycle
    
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - lifecycle
    
    init(_ viewControllerFactory: ViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - public
    
    func coordinator(for type: CoordinatorType) -> NavigationCoordinator {
        switch type {
        case .events(let navController):
            return EventsCoordinator(navController, viewControllerFactory: viewControllerFactory)
        }
    }
}
