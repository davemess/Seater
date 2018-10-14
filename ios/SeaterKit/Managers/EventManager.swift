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
    
    public func find(query: String, handler: @escaping (Result<[Event]>) -> Void) {
        eventsService.find(query: query) { (result) in
            switch result {
            case .success(let baseEvents):
                let events = baseEvents.map {
                    return Event(identifier: $0.identifier, title: $0.title, location: $0.location, date: $0.date, imageUrl: $0.imageUrl, favorited: false)
                }
                handler(.success(events))
            case .failure(let error):
                os_log("did receive error %{public}@", log: self.log, type: .error, error.localizedDescription)
                handler(.failure(error))
            }
        }
    }
}
