//
//  EventsServiceExtensions.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import SeaterKit

extension EventsServiceEvent {
    
    init?(_ event: SeatGeekEvent) {
        guard let imageUrl = event.performers?.first?.image else { return nil }
        
        let identifier = "\(event.identifier)"
        let title = event.title
        let location = event.venue.displayLocation
        let date = event.datetime
        
        self.init(identifier: identifier, title: title, location: location, date: date, imageUrl: imageUrl)
    }
}
