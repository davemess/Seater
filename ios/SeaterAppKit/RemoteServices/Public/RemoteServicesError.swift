//
//  RemoteServicesError.swift
//  RemoteServices
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// Summarizes error types which may be encountered.
public enum RemoteServicesError: Error {
    case invalidOperation(Error)
    case invalidStatusCode(Int)
    case unknown
}
