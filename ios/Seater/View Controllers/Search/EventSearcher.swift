//
//  EventSearcher.swift
//  Seater
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import SeaterKit
import AppUI
import os.log

/// Defines callbacks on an EventSearcher.
protocol EventSearcherDelegate: AnyObject {
    func searcher(_ searcher: EventSearcher, didCompleteWith results: [Event])
    func searcher(_ searcher: EventSearcher, didFailWith error: Error)
}

/// Coordinates searching for events.
class EventSearcher {
    
    // MARK: - public properties
    
    weak var delegate: EventSearcherDelegate?
    
    // MARK: - private properties
    
    private let eventManager: EventManager
    private(set) var isSearching: Bool = false
    private var cancellable: Cancellable?
    private var debounce: DispatchWorkItem?
    private let log = AppLogger.log(.core)
    
    // MARK: - lifecycle
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
    }
    
    // MARK: - public funcs
    
    func search(_ query: String) {
        os_log("EventSearcher will enqueue", log: log, type: .info)
        debounce?.cancel()
        
        let requestWorkItem = DispatchWorkItem {
            self.cancellable?.cancel()
            
            let cancellable = self.eventManager.find(query: query, handler: { (result) in
                switch result {
                case .success(let items):
                    self.delegate?.searcher(self, didCompleteWith: items)
                case .failure(let error):
                    self.delegate?.searcher(self, didFailWith: error)
                }
            })
            self.cancellable = cancellable
        }
        
        // Save the new work item and execute it after 250 ms
        debounce = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)
    }
    
    func cancel() {
        os_log("EventSearcher will cancel", log: log, type: .info)
        cancellable?.cancel()
        debounce?.cancel()
    }
}
