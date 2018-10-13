//
//  AppLogger.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import os.log

/// Factory for supplying log utilities.
struct AppLogger {
    
    // swiftlint:disable identifier_name
    enum Category: String {
        case core
        case ui
        case model
    }
    // swiftlint:enable identifier_name
    
    static func log(_ logType: Category) -> OSLog {
        switch logType {
        case .core: return coreLog
        case .ui: return uiLog
        case .model: return modelLog
        }
    }
    
    private static let coreLog = OSLog(subsystem: subsystem, category: Category.core.rawValue)
    private static let uiLog = OSLog(subsystem: subsystem, category: Category.ui.rawValue)
    private static let modelLog = OSLog(subsystem: subsystem, category: Category.model.rawValue)
    
    private static var subsystem: String {
        return Bundle.main.bundleIdentifier ?? "com.davemess.seater"
    }
}
