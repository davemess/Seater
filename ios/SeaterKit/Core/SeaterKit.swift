//
//  SeaterKit.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import Cache
import os.log

/// Entry point to the concrete classes of the SeaterKit.
public class SeaterKit {
    
    // MARK: - static properties
    
    static public let apiVersion = 1
    static let log = SeaterKitLogger.log(.core)
    
    // MARK: - public properties
    
    public lazy var eventManager: EventManager = {
        precondition(isInitialized, initAssertion)
        let eventsService = serviceProvider.eventsService
        let storage: Storage<NSString, Event> = Storage(configuration: serviceProvider.storageConfiguration)
        let eventManager = EventManager(eventsService: eventsService, storage: storage)
        return eventManager
    }()
    
    // MARK: - private properties
    
    private var serviceProvider: SeaterKitServiceProvider!
    private var isInitialized: Bool = false
    private let initAssertion = "BrickListsKit must be initialized before use."
    
    // MARK: - lifecycle
    
    public static func initialize(with provider: SeaterKitServiceProvider) {
        shared.serviceProvider = provider
        shared.isInitialized = true
        
        os_log("SeaterKit initialized", log: log, type: .info)
    }
    
    static public var shared = SeaterKit()
    private init() {}
}
