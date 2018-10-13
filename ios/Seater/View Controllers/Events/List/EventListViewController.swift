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
    private let log = AppLogger.log(.ui)
    
    private var dataSource: GenericDataSource<Event>
    
    // MARK: - lifecycle
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
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
        
        reloadData()
        
        os_log("%{public}@ viewDidLoad", log: log, type: .info, self.description)
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
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        self.title = NSLocalizedString("Events", comment: "")
    }
    
    // MARK: - data
    
    private func reloadData() {
        eventManager.find { (result) in
            switch result {
            case .success(let items):
                self.dataSource.update(with: [""], items: [items])
                self.reloadView()
            case .failure(let error): ()
                self.present(error)
            }
        }
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

extension EventListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // TODO
    }
}
