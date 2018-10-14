//
//  SeatGeekEventsService.swift
//  SeatGeekSDK
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import SeaterKit
import Results
import RemoteServices

/// A concrete EventsService which will interact with the SeatGeekAPI.
class SeatGeekEventsService: EventsService {
    
    enum Error: Swift.Error {
        case invalidResponse(Int)
    }
    
    // MARK: - private properties
    
    private let apiKey: String
    private let remoteService: RemoteService<SeatGeekOperation> = RemoteService()
    private lazy var decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }()
    
    // MARK: - lifecycle
    
    public init(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - EventsService
    
    public func find(query: String, handler: @escaping (Result<[EventsServiceEvent]>) -> Void) {
        let operation: SeatGeekOperation = .findEvents(clientId: apiKey, query: query)
        remoteService.performOperation(operation) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    switch response.status {
                    case .informational(let code), .redirection(let code), .clientError(let code), .serverError(let code):
                        let error = Error.invalidResponse(code)
                        handler(.failure(error))
                        
                    case .success:
                        if let data = response.data {
                            do {
                                let responseEvents = try self.decoder.decode(SeatGeekEventsResponse.self, from: data).events
                                let mappedEvents: [EventsServiceEvent] = responseEvents.map({ EventsServiceEvent($0) }).compactMap({ $0 })
                                handler(.success(mappedEvents))
                            } catch {
                                handler(.failure(error))
                            }
                        }
                    }
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
    }
}