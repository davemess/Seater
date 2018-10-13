//
//  AnalyticEvent.swift
//  AppAnalytics
//
//  Created by David Messing on 10/13/18.
//

import Foundation

public typealias CustomAttributes = [String: Any]

/**
 Defines types of events which may be recorded by analytic services (modeled after Answers events).
 
 - contentView: [name, contentType, contentId, attributes]
 - share: [method, name, contentType, contentId, attributes]
 - custom: [name, attributes]
 */
public enum AnalyticEvent {
    case contentView(String?, String?, String?, CustomAttributes?)
    case share(String?, String?, String?, String?, CustomAttributes?)
    case custom(String, CustomAttributes?)
}

extension AnalyticEvent: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case let .contentView(name, _, _, _):
            return name ?? "custom"
            
        case let .share(_, name, _, _, _):
            return name ?? "custom"
            
        case let .custom(name, _):
            return name
        }
    }
}
