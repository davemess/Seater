//
//  RemoteServiceOperation.swift
//  RemoteServices
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// Describes a protocol for generating remote service requests.
/// Implementations must only be capable of supplying a configuration object
/// in order for the RemoteService to process.
public protocol RemoteServiceOperation {
    var configuration: RemoteServiceRequestConfiguration { get }
}

/// Error types which may be encountered.
enum RemoteServiceOperationError: Error {
    case url
}

extension RemoteServiceOperation {
    
    func url() throws -> URL {
        let components = urlComponents(scheme: scheme, host: host, path: path, queryItems: urlQueryItems)
        if let url = components?.url {
            return url
        } else {
            throw RemoteServiceOperationError.url
        }
    }
    
    // MARK: - private
    
    private var path: String {
        return configuration.urlComponents.path
    }
    
    private var scheme: String {
        return configuration.scheme.rawValue
    }
    
    private var host: String {
        return configuration.baseURL
    }
    
    private var urlQueryItems: [URLQueryItem]? {
        let items = configuration.urlComponents.queryItems
        var queryItems: [URLQueryItem] = []
        _ = items?.reduce(into: queryItems) {
           queryItems.append(URLQueryItem(name: $1.0, value: $1.1))
        }
        
        return queryItems
    }
    
    private func urlComponents(scheme: String?, host: String?, path: String, queryItems: [URLQueryItem]?) -> URLComponents? {
        guard var components = URLComponents(string: path) else { return nil }
        components.host = host
        components.scheme = scheme
        components.queryItems = queryItems
        
        return components
    }
}

extension RemoteServiceOperation {
    
    func urlRequest() throws -> URLRequest {
        let url = try self.url()
        return URLRequest(url: url, httpMethod: httpMethod, httpBody: httpBody)
    }
    
    // MARK: - private
    
    private var httpMethod: String {
        return configuration.method.rawValue
    }
    
    private var httpBody: Data? {
        return configuration.payload
    }
}

extension URLRequest {
    
    init(url: URL, httpMethod: String, httpBody: Data?) {
        self.init(url: url)
        self.httpMethod = httpMethod
        self.httpBody = httpBody
    }
}
