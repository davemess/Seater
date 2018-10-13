//
//  EventsService.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import Results

/// Defines a service-based Event.
public struct EventsServiceEvent {
    
    public let identifier: String
    public let title: String
    public let location: String
    public let date: Date
    public let imageUrl: String
    
    public init(identifier: String, title: String, location: String, date: Date, imageUrl: String) {
        self.identifier = identifier
        self.title = title
        self.location = location
        self.date = date
        self.imageUrl = imageUrl
    }
}

/// Defines methods for fetching Event data from a (remote) source.
public protocol EventsService {
    func find(query: String, handler: @escaping (Result<[EventsServiceEvent]>) -> Void)
//    func get(identifier: String, handler: @escaping (Result<EventsServiceEvent>) -> Void)
}
