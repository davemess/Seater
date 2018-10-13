//
//  SeaterAnalyticEvent.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppAnalytics

/// Describes a protocol for producing analytic events.
protocol AnalyticEventConvertible {
    func toAnalyticEvent() -> AnalyticEvent
}

/// Definitions for Seater's analytic event types.
enum SeaterAnalyticEvent {
    case appLaunch
}

extension SeaterAnalyticEvent: AnalyticEventConvertible {
    
    func toAnalyticEvent() -> AnalyticEvent {
        switch self {
        case .appLaunch:
            return AnalyticEvent.custom("applicationDidLaunch", nil)
        }
    }
}
