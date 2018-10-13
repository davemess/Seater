//
//  SeatGeekSDK.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import SeaterKit

/// Concrete EventsService which pulls from the SeatGeekAPI.
public class SeatGeekSDK {
    
    // MARK: - public properties
    
    public lazy var eventsService: EventsService = {
        return SeatGeekEventsService(apiKey)
    }()
    
    // MARK: - private properties
    
    let apiKey: String
    
    // MARK: - lifecycle
    
    public init(with apiKey: String) {
        self.apiKey = apiKey
    }
}
