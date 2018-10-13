//
//  ViewControllerFactory.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Factory for creating view controllers. Use this to inject dependencies.
class ViewControllerFactory {
    
    enum ViewControllerType {
        case eventList(delegate: EventListViewControllerDelegate?)
    }
    
    // MARK: - public
    
    func viewController(for type: ViewControllerType) -> UIViewController {
        switch type {
        case .eventList(let delegate):
            let viewController = EventListViewController()
            viewController.delegate = delegate
            return viewController
        }
    }
}
