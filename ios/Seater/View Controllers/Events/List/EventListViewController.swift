//
//  EventListViewController.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Defines callbacks which may occur in an EventListViewController.
protocol EventListViewControllerDelegate: AnyObject {
    func viewController(_ viewController: EventListViewController, didSelect event: AnyObject)
}

/// Displays Events in a list view.
class EventListViewController: UIViewController {

    // MARK: - outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - public properties
    
    weak var delegate: EventListViewControllerDelegate?
    
    // MARK: - lifecycle
    
    // MARK: - view lifecycle
    
    // MARK: - view
    
}

extension EventListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension EventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.viewController(self, didSelect: NSObject())
    }
}

extension EventListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // TODO
    }
}
