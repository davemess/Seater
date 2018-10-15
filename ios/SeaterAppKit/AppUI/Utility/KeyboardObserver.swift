//
//  KeyboardObserver.swift
//  AppUI
//
//  Created by David Messing on 10/15/18.
//

import UIKit

/// Defines callbacks for KeyboardObserver.
public protocol KeyboardObserverDelegate: class {
    func keyboardObserverDidObserve(_ observer: KeyboardObserver, event: KeyboardEventInfo)
}

/// Utility class for observing application keyboard notifications.
public class KeyboardObserver {
    
    let notificationCenter = NotificationCenter.default
    let keyboardNotificationEvents: [Notification.Name: KeyboardEventType] = [
        UIResponder.keyboardWillShowNotification: .willShow,
        UIResponder.keyboardDidShowNotification: .didShow,
        UIResponder.keyboardWillHideNotification: .willHide,
        UIResponder.keyboardDidHideNotification: .didHide]
    
    public weak var delegate: KeyboardObserverDelegate?
    var eventTypes: [KeyboardEventType]
    
    // MARK: - lifecycle
    
    public init(_ eventTypes: [KeyboardEventType]) {
        self.eventTypes = eventTypes
        
        registerNotifications()
    }
    
    deinit {
        unregisterNotifications()
    }
    
    // MARK: - notifications
    
    private func registerNotifications() {
        for event in keyboardNotificationEvents.keys {
            notificationCenter.addObserver(self, selector: #selector(KeyboardObserver.keyboardEvent(_:)), name: event, object: nil)
        }
    }
    
    private func unregisterNotifications() {
        for event in keyboardNotificationEvents.keys {
            notificationCenter.removeObserver(self, name: event, object: nil)
        }
    }
    
    // MARK: - private
    
    @objc private func keyboardEvent(_ note: Notification) {
        let eventName = note.name
        if let keyboardEventType = keyboardNotificationEvents[eventName] {
            if eventTypes.contains(keyboardEventType) {
                let userInfo = note.userInfo
                let eventInfo = KeyboardEventInfo(keyboardEventType, info: userInfo as [AnyHashable: Any]?)
                delegate?.keyboardObserverDidObserve(self, event: eventInfo)
            }
        }
    }
}
