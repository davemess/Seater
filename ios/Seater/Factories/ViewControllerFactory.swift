//
//  ViewControllerFactory.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit

/// Factory for creating view controllers. Use this to inject dependencies.
class ViewControllerFactory {
    
    enum ViewControllerType {
        case eventList(delegate: EventListViewControllerDelegate?)
    }
    
    // MARK: - private properties
    
    private lazy var eventManager: EventManager = {
        return SeaterKit.shared.eventManager
    }()
    
    // MARK: - public
    
    func viewController(for type: ViewControllerType) -> UIViewController {
        switch type {
        case .eventList(let delegate):
            let viewController = EventListViewController(eventManager: eventManager)
            viewController.delegate = delegate
            return viewController
        }
    }
}