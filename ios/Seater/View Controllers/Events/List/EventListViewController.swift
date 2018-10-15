//
//  EventListViewController.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit
import AppUI
import os.log

/// Defines callbacks which may occur in an EventListViewController.
protocol EventListViewControllerDelegate: AnyObject {
    func viewController(_ viewController: EventListViewController, didSelect event: Event)
}

/// Displays Events in a list view.
class EventListViewController: UIViewController, ErrorAlertRenderer {
    
    // MARK: - nested defintions
    
    /// Configuration store for associated values.
    struct Configuration {
        static let decelerationRate = UIScrollView.DecelerationRate.fast
        static let cellHeight: CGFloat = 100.0
    }

    // MARK: - outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - public properties
    
    weak var delegate: EventListViewControllerDelegate?
    
    // MARK: - private properties
    
    private let eventManager: EventManager
    private let searchController: EventSearchController
    private let log = AppLogger.log(.ui)
    
    private var dataSource: GenericDataSource<Event>
    
    // MARK: - lifecycle
    
    init(eventManager: EventManager, searchController: EventSearchController) {
        self.eventManager = eventManager
        self.searchController = searchController
        self.dataSource = GenericDataSource<Event>(sections: [], items: [])
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureViewController()
        
        os_log("%{public}@ viewDidLoad", log: log, type: .info, self.description)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetView(animated: animated)
    }
    
    // MARK: - view
    
    private func configureView() {
        tableView.registerReusableCell(EventListTableViewCell.self)
        tableView.rowHeight = Configuration.cellHeight
        tableView.decelerationRate = Configuration.decelerationRate
    }
    
    private func reloadView() {
        tableView.reloadData()
    }
    
    private func resetView(animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    private func configureViewController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search Events...", comment: "")
        searchController.searchBar.sizeToFit()
        searchController.searchDelegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        title = NSLocalizedString("Events", comment: "")
        definesPresentationContext = true
    }
}

extension EventListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = dataSource.item(at: indexPath) else { preconditionFailure() }
        
        let cell: EventListTableViewCell = tableView.dequeueReusableCell(indexPath)
        cell.configure(with: item)
        return cell
    }
}

extension EventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.item(at: indexPath) else { preconditionFailure() }
        delegate?.viewController(self, didSelect: item)
    }
}

extension EventListViewController: EventDetailViewControllerDelegate {
    
    func viewController(_ viewController: EventDetailViewController, didToggleFavorite event: Event) {
        if let indexPath = dataSource.indexPath(of: event) {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension EventListViewController: EventSearchControllerDelegate {
    
    func controller(_ controller: EventSearchController, didCompleteWith results: [Event]) {
        os_log("%{public}@ did reload %i objects", log: self.log, type: .info, self, results.count)
        self.dataSource.update(with: ["results"], items: [results])
        self.reloadView()
    }
    
    func controller(_ controller: EventSearchController, didFailWith error: Error) {
        os_log("%{public}@ did receive error %{public}@", log: self.log, type: .error, self, error.localizedDescription)
        if error.isURLCancellation {
            // cancellation error, don't present
        } else {
            self.present(error)
        }
    }
}
