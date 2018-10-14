//
//  RemoteServiceReplyHandler.swift
//  RemoteServices
//
//  Created by David Messing on 10/14/18.
//

import Foundation
import Results

/// A simple data structure which wraps the response params from a URLSessionTask.
struct RemoteServiceReply {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

/// A dedicated reply handler for managing URLSessionTask replies.
class RemoteServiceReplyHandler {
    
    func handle(_ reply: RemoteServiceReply, completion: @escaping (Result<RemoteServiceResponse>) -> Void) {
        if let error = reply.error {
            handle(error, completion: completion)
        } else if let response = reply.response as? HTTPURLResponse {
            handle(response, data: reply.data, completion: completion)
        } else {
            handle(RemoteServicesError.unknown, completion: completion)
        }
    }
    
    // MARK: - private
    
    private func handle(_ error: Error, completion: @escaping (Result<RemoteServiceResponse>) -> Void) {
        completion(.failure(error))
    }
    
    private func handle(_ response: HTTPURLResponse, data: Data?, completion: @escaping (Result<RemoteServiceResponse>) -> Void) {
        do {
            let serviceResponse = try RemoteServiceResponse(response: response, data: data)
            completion(.success(serviceResponse))
        } catch {
            handle(error, completion: completion)
        }
    }
}
