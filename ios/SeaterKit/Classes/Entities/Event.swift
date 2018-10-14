//
//  Event.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Data structure which represents a Event.
public class Event: Codable {
    
    public let identifier: String
    public let title: String
    public let location: String
    public let date: Date
    public let imageUrl: String // TODO: convert to URL
    public var favorited: Bool
    
    public init(identifier: String,
                title: String,
                location: String,
                date: Date,
                imageUrl: String,
                favorited: Bool) {
        self.identifier = identifier
        self.title = title
        self.location = location
        self.date = date
        self.imageUrl = imageUrl
        self.favorited = favorited
    }
}

extension Event {
    
    convenience init(event: EventsServiceEvent, favorited: Bool) {
        self.init(identifier: event.identifier,
                  title: event.title,
                  location: event.location,
                  date: event.date,
                  imageUrl: event.imageUrl,
                  favorited: favorited)
    }
}
