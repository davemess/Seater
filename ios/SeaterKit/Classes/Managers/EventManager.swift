//
//  EventManager.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Manages Event operations.
public class EventManager {
    
    // MARK: - private properties
    
    // MARK: - lifecycle
    
    // MARK: - public funcs
    
    public func find(handler: @escaping (Result<[Event]>) -> Void) {
        var events: [Event] = []
        for _ in 0..<50 {
            let event = Event(identifier: "1234",
                title: "Hello",
                location: "World",
                date: Date(),
                imageUrl: "abc",
                favorited: false
            )
            events.append(event)
        }
        
        handler(.success(events))
    }
}
