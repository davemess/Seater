//
//  ErrorExtensions.swift
//  Seater
//
//  Created by David Messing on 10/15/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

extension Error {
    
    var isURLCancellation: Bool {
        let err = self as NSError
        return err.domain == "NSURLErrorDomain" && err.code == NSURLErrorCancelled
    }
}
