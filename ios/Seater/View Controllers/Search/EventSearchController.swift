//
//  EventSearchController.swift
//  Seater
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit
import AppUI

/// Callbacks on an EventSearchController.
protocol EventSearchControllerDelegate: AnyObject {
    func controller(_ controller: EventSearchController, didCompleteWith results: [Event])
    func controller(_ controller: EventSearchController, didFailWith error: Error)
}

/// A custom search controller for fetching Events.
class EventSearchController: UISearchController {
    
    weak var searchDelegate: EventSearchControllerDelegate?
    
    private lazy var searcher: EventSearcher = {
        // FIXME: This shoudl be injected, not shared access
        let eventManager = SeaterKit.shared.eventManager
        let searcher = EventSearcher(eventManager: eventManager)
        searcher.delegate = self
        return searcher
    }()

    // MARK: - lifecycle
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        
        self.searchResultsUpdater = self
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func setup() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension EventSearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            let sanitizedSearchString = searchString.removeWhitespace()
            if sanitizedSearchString.count > 0 {
                NetworkIndicatorManager.shared.visible = true
                searcher.search(sanitizedSearchString)
            } else {
                searcher.cancel()
                searchDelegate?.controller(self, didCompleteWith: [])
            }
        }
    }
}

extension EventSearchController: EventSearcherDelegate {
    
    func searcher(_ searcher: EventSearcher, didCompleteWith results: [Event]) {
        searchDelegate?.controller(self, didCompleteWith: results)
        NetworkIndicatorManager.shared.visible = false
    }
    
    func searcher(_ searcher: EventSearcher, didFailWith error: Error) {
        searchDelegate?.controller(self, didFailWith: error)
        NetworkIndicatorManager.shared.visible = false
    }
}
