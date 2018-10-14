//
//  EventManager.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import Results
import os.log

/// Manages Event operations.
public class EventManager {
    
    // MARK: - private properties
    
    private let eventsService: EventsService
    private let log = SeaterKitLogger.log(.eventManager)

    // MARK: - lifecycle

    init(eventsService: EventsService) {
        self.eventsService = eventsService
    }
    
    // MARK: - public funcs
    
    /// Perform an Event search with the specified query tag.
    ///
    /// - Parameters:
    ///   - query: A string to search against. Eg. search "Ravens" for Baltimore Ravens events.
    ///   - handler: A completion handler containing a Result with an Events array or Error.
    public func find(query: String, handler: @escaping (Result<[Event]>) -> Void) {
        eventsService.find(query: query) { (result) in
            switch result {
            case .success(let baseEvents):
                let events = baseEvents.map { return Event(event: $0) }
                handler(.success(events))
            case .failure(let error):
                os_log("did receive error %{public}@", log: self.log, type: .error, error.localizedDescription)
                handler(.failure(error))
            }
        }
    }
    
    /// Perform an Event load operation with the specified identifier.
    ///
    /// - Parameters:
    ///   - event: The Event to reload.
    ///   - handler: A completion handler containing a Result with an Event or Error.
    public func reload(event: Event, handler: @escaping (Result<Event>) -> Void) {
        eventsService.get(eventId: event.identifier) { result in
            switch result {
            case .success(let baseEvent):
                let reloaded = Event(event: baseEvent)
                handler(.success(reloaded))
            case .failure(let error):
                os_log("did receive error %{public}@", log: self.log, type: .error, error.localizedDescription)
                handler(.failure(error))
            }
        }
    }
}
