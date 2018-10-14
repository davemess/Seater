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
class EventDetailViewController: UIViewController, ErrorAlertRenderer {
    
    // MARK: - outlets
    
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    // MARK: - private properties
    
    private let eventManager: EventManager
    private var event: Event
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
        
        reloadView()
        reloadData()
        
        os_log("%{public}@ viewDidLoad", log: log, type: .info, self.description)
    }
    
    // MARK: - view
    
    private func reloadView() {
        self.title = self.event.title
        
        //eventImageView.image =
        locationLabel.text = event.location
        dateLabel.text = DateViewFormatter.format(event.date, style: .long)
    }
    
    // MARK: - data
    
    private func reloadData() {
        NetworkIndicatorManager.shared.visible = true
        
        eventManager.reload(event: event) { (result) in
            NetworkIndicatorManager.shared.visible = false
            switch result {
            case .success(let item):
                os_log("%{public}@ did reload item with identifier %@", log: self.log, type: .info, self, item.identifier)
                self.event = item
                self.reloadView()
            case .failure(let error):
                os_log("%{public}@ did receive error %{public}@", log: self.log, type: .error, self, error.localizedDescription)
                self.present(error)
            }
        }
    }
}
