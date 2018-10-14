//
//  SeaterKitServiceProvider.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Describes an interface for supplying associated Services.
public protocol SeaterKitServiceProvider {
    var eventsService: EventsService { get }
}
