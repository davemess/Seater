//
//  RemoteService.swift
//  RemoteServices
//
//  Created by David Messing on 10/13/18.
//

import Foundation
import Results

/// A generic remote networking service.
public class RemoteService<T: RemoteServiceOperation> {
    
    // MARK: - private properties
    
    private let sessionConfiguration: URLSessionConfiguration
    
    private lazy var session: URLSession = {
        return URLSession(configuration: sessionConfiguration)
    }()
    
    private lazy var replyHandler: RemoteServiceReplyHandler = {
        return RemoteServiceReplyHandler()
    }()
    
    // MARK: - lifecycle
    
    public init(sessionConfiguration: URLSessionConfiguration = .default) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    // MARK: - public funcs
    
    public func performOperation(_ operation: RemoteServiceOperation, completion: @escaping (Result<RemoteServiceResponse>) -> Void) -> URLSessionTask? {
        do {
            let request = try operation.urlRequest()
            let task = session.dataTask(with: request) { (data, response, error)  in
                let reply = RemoteServiceReply(data: data, response: response, error: error as Error?)
                self.replyHandler.handle(reply, completion: completion)
            }
            
            task.resume()
            
            return task
        } catch {
            completion(.failure(error))
            return nil
        }
    }
}
