//
//  RemoteServiceRequestConfiguration.swift
//  RemoteServices
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// The configuration operation defines parameters for a remote network request.
public struct RemoteServiceRequestConfiguration {
    
    // MARK: - nested types
    
    /// Defines the type of HTTP protocol to use.
    public enum HttpProtocol: String {
        case http
        case https
    }
    
    /// Defines the type of HTTP method to use.
    public enum HttpMethod: String {
        case get = "GET"
    }
    
    /// Defines the HTTP Content Type.
    public enum HTTPContentType: String {
        case json = "application/json"
    }
    
    /// Includes path and query param options.
    public struct PathComponents {
        let path: String
        let queryItems: [String: String?]?
        
        public init(path: String, queryItems: [String: String?]? = nil) {
            self.path = path
            self.queryItems = queryItems
        }
    }
    
    // MARK: - public properties
    
    public let baseURL: String
    public let scheme: HttpProtocol
    public let method: HttpMethod
    public let contentType: HTTPContentType
    public let urlComponents: PathComponents
    public let payload: Data?
    
    // MARK: - lifecycle
    
    public init(baseURL: String,
                scheme: HttpProtocol,
                method: HttpMethod,
                contentType: HTTPContentType,
                urlComponents: PathComponents,
                payload: Data? = nil) {
        self.baseURL = baseURL
        self.scheme = scheme
        self.method = method
        self.contentType = contentType
        self.urlComponents = urlComponents
        self.payload = payload
    }
}
