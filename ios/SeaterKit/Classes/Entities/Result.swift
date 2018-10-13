//
//  Result.swift
//  SeaterKit
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

/// Options for an operation result.
public enum Result<T> {
    case success(T)
    case failure(Error)
}
