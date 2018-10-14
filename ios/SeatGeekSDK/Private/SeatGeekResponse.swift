//
//  SeatGeekResponse.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Maps response from /events in SeatGeekAPI.
struct SeatGeekEventsResponse: Decodable {
    
    let events: [SeatGeekEvent]
}

/// Maps event response.
struct SeatGeekEvent: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case venue = "venue"
        case datetime = "datetime_utc"
        case performers
    }
    
    let identifier: Int
    let title: String
    let datetime: Date
    let venue: SeatGeekVenue
    let performers: [SeatGeekPerformer]?
}

/// Maps venue response.
struct SeatGeekVenue: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case displayLocation = "display_location"
    }
    
    let displayLocation: String
}

/// Maps performer response.
struct SeatGeekPerformer: Decodable {
    let image: String?
}
