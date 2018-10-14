//
//  SeaterKitLogger.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import os.log

/// Factory for supplying log utilities.
struct SeaterKitLogger {
    
    enum Category: String {
        case core
        case eventManager
    }
    
    static func log(_ logType: Category) -> OSLog {
        switch logType {
        case .core:
            return coreLog
        case .eventManager:
            return eventManagerLog
        }
    }
    
    private static let coreLog = OSLog(subsystem: subsystem, category: Category.core.rawValue)
    private static let eventManagerLog = OSLog(subsystem: subsystem, category: Category.eventManager.rawValue)
    
    private static var subsystem: String = "com.davemess.SeaterKit"
}
