//
//  EventsCoordinator.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Navigation coordinator Events display.
class EventsCoordinator: NavigationCoordinator {
    
    let navigationController: UINavigationController
    
    // MARK: - lifecycle
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - NavigationCoordinator
    
    func start(_ animated: Bool) {
        let viewController = ViewController()
        navigationController.pushViewController(viewController, animated: animated)
    }
}
