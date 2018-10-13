//
//  Event.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Data structure which represents a Event.
public struct Event {
    
    public let identifier: String
    public let title: String
    public let location: String
    public let date: Date
    public let imageUrl: String // convert to URL
    public let favorited: Bool
}
