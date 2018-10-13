//
//  AnalyticsManager.swift
//  AppAnalytics
//
//  Created by David Messing on 10/13/18.
//

import Foundation
import os.log

/// Defines an interface for recording analytic events.
public protocol AnalyticsRecorder {
    func record(_ event: AnalyticEvent)
}

/// A singleton which is enabled to log analytic events by means of a registered recorder.
public class AnalyticsManager {
    
    // MARK: - private properties
    
    private var recorder: AnalyticsRecorder?
    private var log = OSLog(subsystem: "com.davemess.AFNAppKit", category: "Analytics")
    
    static public var shared = AnalyticsManager()
    private init() {}
    
    // MARK: - public
    
    public func register(_ recorder: AnalyticsRecorder) {
        self.recorder = recorder
    }
    
    public func log(_ event: AnalyticEvent) {
        guard let recorder = self.recorder else {
            printNoRecorder()
            return
        }
        
        recorder.record(event)
        os_log("Event recorded: %@", log: log, type: .info, event.description)
    }
    
    // MARK: - private
    
    private func printNoRecorder() {
        os_log("%@ has no recorder configured. Message will be ignored.", log: log, type: .error, self.debugDescription)
    }
}

extension AnalyticsManager: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return String(format: "<%@>", String(describing: type(of: self)))
    }
}
