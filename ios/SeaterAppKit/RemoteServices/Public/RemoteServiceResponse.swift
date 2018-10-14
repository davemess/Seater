//
//  RemoteServiceResponse.swift
//  RemoteServices
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// Wraps service response properties.
public struct RemoteServiceResponse {
    
    // MARK: - nested types
    
    /// This status enum will contain status code descriptions.
    public enum Status {
        case informational(Int)
        case success(Int)
        case redirection(Int)
        case clientError(Int)
        case serverError(Int)
        
        init?(statusCode: Int) {
            switch statusCode {
            case 100...199:
                self = .informational(statusCode)
            case 200...299:
                self = .success(statusCode)
            case 300...399:
                self = .redirection(statusCode)
            case 400...499:
                self = .clientError(statusCode)
            case 500...599:
                self = .serverError(statusCode)
            default:
                return nil
            }
        }
    }
    
    // MARK: - public properties
    
    public let status: Status
    public let data: Data?
    public let headers: [AnyHashable: Any]
    
    // MARK: - lifecycle
    
    init(response: HTTPURLResponse, data: Data?) throws {
        let statusCode = response.statusCode
        guard let status = Status(statusCode: statusCode) else {
            throw RemoteServicesError.invalidStatusCode(statusCode)
        }
        
        self.status = status
        self.data = data
        self.headers = response.allHeaderFields
    }
}
