//
//  NavigationCoordinator.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Coordinators are responsible for directing view controller
/// flow within an application.
protocol NavigationCoordinator: class {
    
    var navigationController: UINavigationController { get }
    
    /// Called to kick off coordinator operations.
    func start(_ animated: Bool)
}
