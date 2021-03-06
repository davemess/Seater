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
        case eventDetail(event: Event, delegate: EventDetailViewControllerDelegate?)
    }
    
    // MARK: - private properties
    
    private lazy var eventManager: EventManager = {
        // FIXME: This should be injected, not shared access
        return SeaterKit.shared.eventManager
    }()
    
    // MARK: - public
    
    func viewController(for type: ViewControllerType) -> UIViewController {
        switch type {
        case .eventList(let delegate):
            let searchController = EventSearchController(searchResultsController: nil)
            let viewController = EventListViewController(eventManager: eventManager, searchController: searchController)
            viewController.delegate = delegate
            return viewController
            
        case .eventDetail(let event, let delegate):
            let viewController = EventDetailViewController(eventManager: eventManager, event: event)
            viewController.delegate = delegate
            return viewController
        }
    }
}
