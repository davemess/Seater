//
//  EventAction.swift
//  Seater
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit

/// Describes actions to take on an Event.
enum EventAction {
    case favorite(Event)
    case unfavorite(Event)
}

extension EventAction {
    
    func barButtonItem(_ style: UIBarButtonItem.Style = .plain, target: Any?, action: Selector?) -> UIBarButtonItem {
        switch self {
        case .favorite:
            return UIBarButtonItem(image: #imageLiteral(resourceName: "heart_outline"), style: .plain, target: target, action: action)
        case .unfavorite:
            return UIBarButtonItem(image: #imageLiteral(resourceName: "heart_filled"), style: .plain, target: target, action: action)
        }
    }
}
