//
//  DateViewFormatter.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Utility class for formatting Dates for dislpay.
class DateViewFormatter {
    
    enum DateStyle {
        case long // Mon, 13 Jun 2016 07:05 PM
    }
    
    private class var longFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    class func format(_ date: Date, style: DateStyle) -> String {
        switch style {
        case .long:
            return longFormatter.string(from: date)
        }
    }
}
