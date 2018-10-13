//
//  SeatGeekEventsService.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import SeaterKit
import Results

/// A concrete EventsService which will interact with the SeatGeekAPI.
class SeatGeekEventsService: EventsService {
    
    // MARK: - private properties
    
    let apiKey: String
    
    // MARK: - lifecycle
    
    public init(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - EventsService
    
    public func find(query: String, handler: @escaping (Result<[EventsServiceEvent]>) -> Void) {
        let array = Array(repeating: 0, count: 50)
        let events: [EventsServiceEvent] = array.map { _ in
            return EventsServiceEvent(identifier: "1234", title: "Hello", location: "World", date: Date(), imageUrl: "abc")
        }
        handler(.success(events))
    }
}
