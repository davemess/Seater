//
//  EventsCoordinator.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit

/// Navigation coordinator Events display.
class EventsCoordinator: NavigationCoordinator {
    
    let navigationController: UINavigationController
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - lifecycle
    
    init(_ navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - NavigationCoordinator
    
    func start(_ animated: Bool) {
        let type: ViewControllerFactory.ViewControllerType = .eventList(delegate: self)
        let viewController = viewControllerFactory.viewController(for: type)
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension EventsCoordinator: EventListViewControllerDelegate {
    
    func viewController(_ viewController: EventListViewController, didSelect event: Event) {
        // TODO: push detail view
    }
}
