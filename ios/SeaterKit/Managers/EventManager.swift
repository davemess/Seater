//
//  EventManager.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import Results
import Cache
import os.log

/// Manages Event operations.
public class EventManager {
    
    // MARK: - private properties
    
    private let eventsService: EventsService
    private let storage: Storage<NSString, Event>
    private let log = SeaterKitLogger.log(.eventManager)

    // MARK: - lifecycle

    init(eventsService: EventsService, storage: Storage<NSString, Event>) {
        self.eventsService = eventsService
        self.storage = storage
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
                let events = baseEvents.map { baseEvent -> Event in
                    let favorited = self.isFavorite(event: baseEvent)
                    return Event(event: baseEvent, favorited: favorited)
                }
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
                let favorited = self.isFavorite(event: baseEvent)
                let reloaded = Event(event: baseEvent, favorited: favorited)
                handler(.success(reloaded))
            case .failure(let error):
                os_log("did receive error %{public}@", log: self.log, type: .error, error.localizedDescription)
                handler(.failure(error))
            }
        }
    }
    
    public func toggleFavorite(event: Event, handler: (Event) -> Void) {
        event.favorited.toggle()
        
        let identifier = event.identifier as NSString
        if event.favorited {
            storage[identifier] = event
            handler(event)
        } else {
            storage[identifier] = nil
            handler(event)
        }
    }
    
    // MARK: - private
    
    private func isFavorite(event: EventsServiceEvent) -> Bool {
        let identifier = event.identifier as NSString
        return (self.storage[identifier] != nil)
    }
}
