//
//  SeatGeekOperation.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import RemoteServices

/// Wraps pagination options.
struct SeatGeekPagination {
    static let DefaultLimit = 20
    
    let page: Int
    let limit: Int
    
    init(page: Int = 1, limit: Int = SeatGeekPagination.DefaultLimit) {
        self.page = page
        self.limit = limit
    }
}

/// This enum summarizes and encapsulates individual requests against the
/// SeatGeek API.
enum SeatGeekOperation {
    case findEvents(pagination: SeatGeekPagination, clientId: String, query: String)
    case getEvent(identifier: String, clientId: String)
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
            case page
            case perPage = "per_page"
            case clientId = "client_id"
            case query = "q"
        }
    }
    // swiftlint:enable nesting
    
    // MARK: - RemoteServiceOperation
    
    var configuration: RemoteServiceRequestConfiguration {
        let pathComponents = self.pathComponents
        return RemoteServiceRequestConfiguration(baseURL: Constants.base, scheme: .https, method: .get, contentType: .json, urlComponents: pathComponents)
    }
    
    // MARK: - private
    
    private var pathComponents: Components {
        return Components(path: path, queryItems: queryItems)
    }
    
    private var path: String {
        switch self {
        case .findEvents:
            return "/\(Constants.version)/\(endpoint.rawValue)"
        case .getEvent(let eventId, _):
            return "/\(Constants.version)/\(endpoint.rawValue)/\(eventId)"
        }
    }
    
    private var endpoint: Constants.Endpoint {
        switch self {
        case .findEvents, .getEvent:
            return .events
        }
    }
    
    private var queryItems: [String: String?]? {
        return queryDictionary?.reduce(into: [:]) { $0?[$1.0.rawValue] = $1.1 }
    }
    
    private var queryDictionary: [Constants.QueryKey: String?]? {
        switch self {
        case .findEvents(let pagination, let clientId, let query):
            return [.page: pagination.page.description,
                    .perPage: pagination.limit.description,
                    .clientId: clientId,
                    .query: query]
            
        case .getEvent(_, let clientId):
                return [.clientId: clientId]
        }
    }
}
