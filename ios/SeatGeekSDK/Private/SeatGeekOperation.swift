//
//  SeatGeekOperation.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import RemoteServices

/// This enum summarizes and encapsulates individual requests against the
/// SeatGeek API.
enum SeatGeekOperation {
    case findEvents(clientId: String, query: String)
    //    case getEvent(id: String)
}

extension SeatGeekOperation: RemoteServiceOperation {
    
    // MARK: - nested types
    
    private typealias Components = RemoteServiceRequestConfiguration.PathComponents
    
    // swiftlint:disable nesting
    private struct Constants {
        // host
        static let base = "api.seatgeek.com"
        static let version = "2"
        
        // endpoints
        enum Endpoint: String {
            case events
        }
        
        // query items
        enum QueryKey: String {
            case clientId = "client_id"
            case query = "q"
        }
    }
    // swiftlint:enable nesting
    
    // MARK: - RemoteServiceOperation
    
    var configuration: RemoteServiceRequestConfiguration {
        switch self {
        case .findEvents:
            let pathComponents = self.pathComponents
            return RemoteServiceRequestConfiguration(baseURL: Constants.base, scheme: .https, method: .get, contentType: .json, urlComponents: pathComponents)
        }
    }
    
    // MARK: - private
    
    private var pathComponents: Components {
        switch self {
        case .findEvents:
            return Components(path: path, queryItems: queryItems)
        }
    }
    
    private var path: String {
        return "/\(Constants.version)/\(endpoint.rawValue)"
    }
    
    private var endpoint: Constants.Endpoint {
        switch self {
        case .findEvents:
            return .events
        }
    }
    
    private var queryItems: [String: String?]? {
        return queryDictionary?.reduce(into: [:]) { $0?[$1.0.rawValue] = $1.1 }
    }
    
    private var queryDictionary: [Constants.QueryKey: String?]? {
        switch self {
        case .findEvents(let clientId, let query):
            return [.clientId: clientId, .query: query]
        }
    }
}
