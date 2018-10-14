//
//  EventDetailViewController.swift
//  Seater
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit
import AppUI
import os.log

/// Displays Events in a detail view.
class EventDetailViewController: UIViewController {
    
    // MARK: - outlets

    // MARK: - private properties
    
    private let eventManager: EventManager
    private let event: Event
    private let log = AppLogger.log(.ui)
    
    // MARK: - lifecycle
    
    init(eventManager: EventManager, event: Event) {
        self.eventManager = eventManager
        self.event = event
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        reloadView()
        reloadData()
        
        os_log("%{public}@ viewDidLoad", log: log, type: .info, self.description)
    }
    
    private func configureViewController() {
        self.title = self.event.title
    }
    
    // MARK: - view
    
    private func reloadView() {
        // TODO: set view outlets
    }
    
    // MARK: - data
    
    private func reloadData() {
        // TODO: refresh event
    }
}
