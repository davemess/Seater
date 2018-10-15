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
import Kingfisher
import os.log

/// Defines callbacks which may occur in an EventDetailViewController.
protocol EventDetailViewControllerDelegate: AnyObject {
    func viewController(_ viewController: EventDetailViewController, didToggleFavorite event: Event)
}

/// Displays Events in a detail view.
class EventDetailViewController: UIViewController, ErrorAlertRenderer {
    
    // MARK: - nested types
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10.0
    }
    
    // MARK: - outlets
    
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    // MARK: - public properties
    
    weak var delegate: EventDetailViewControllerDelegate?
    
    // MARK: - private properties
    
    private let eventManager: EventManager
    private var event: Event
    private var reloadedEvent: Event?
    private var currentTask: RetrieveImageTask?
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
        
        reloadView(for: event)
        reloadData()
        
        os_log("%{public}@ viewDidLoad", log: log, type: .info, self.description)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        currentTask?.cancel()
    }
    
    // MARK: - view
    
    private func reloadView(for event: Event) {
        reloadNavigationItem()
        
        //eventImageView.image =
        locationLabel.text = event.location
        dateLabel.text = DateViewFormatter.format(event.date, style: .long)
        eventImageView.kf.indicatorType = .activity
        eventImageView.layer.cornerRadius = Constants.cornerRadius
        currentTask = eventImageView.kf.setImage(with: event.imageUrl, placeholder: #imageLiteral(resourceName: "placeholder"))
    }
    
    private func reloadNavigationItem() {
        self.title = self.event.title
        
        let action: EventAction = event.favorited ? .unfavorite(event) : .favorite(event)
        let barButtonItem = action.barButtonItem(target: self, action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: - data
    
    private func reloadData() {
        NetworkIndicatorManager.shared.visible = true
        
        eventManager.reload(event: event) { (result) in
            NetworkIndicatorManager.shared.visible = false
            switch result {
            case .success(let item):
                os_log("%{public}@ did reload item with identifier %@", log: self.log, type: .info, self, item.identifier)
                self.reloadedEvent = item
                self.reloadView(for: item)
            case .failure(let error):
                os_log("%{public}@ did receive error %{public}@", log: self.log, type: .error, self, error.localizedDescription)
                self.present(error)
            }
        }
    }
    
    // MARK: - actions
    
    @objc private func toggleFavorite() {
        eventManager.toggleFavorite(event: event) { (item) in
            self.reloadedEvent = item
            self.reloadView(for: item)
            self.delegate?.viewController(self, didToggleFavorite: self.event)
        }
    }
}
