//
//  KeyboardEventInfo.swift
//  AppUI
//
//  Created by David Messing on 10/15/18.
//

import UIKit

/// Defines observed keyboard events.
public enum KeyboardEventType {
    case willShow
    case didShow
    case willHide
    case didHide
}

/// Simple data wrapper for observed keyboard.
public struct KeyboardEventInfo {
    
    public let type: KeyboardEventType
    public var keyboardFrame: CGRect?
    public var animationDuration: TimeInterval? = 0
    
    init(_ type: KeyboardEventType, info: [AnyHashable: Any]?) {
        self.type = type
        
        if let info = info {
            let value: NSValue? = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            let duration: NSNumber? = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
            
            keyboardFrame = value?.cgRectValue
            animationDuration = duration?.doubleValue
        }
    }
}
