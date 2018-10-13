//
//  ErrorAlert.swift
//  AppUI
//
//  Created by David Messing on 10/13/18.
//

import UIKit

/// Bundles error display options
public struct ErrorAlert {
    public let title: String
    public let message: String
    public let actions: [UIAlertAction]?
    
    public init(title: String = NSLocalizedString("Error", comment: ""),
                message: String = NSLocalizedString("An error occurred.", comment: ""),
                actions: UIAlertAction...) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

/// Defines a protocol for implementors to generate an ErrorAlert.
public protocol ErrorAlertConvertible {
    var errorAlert: ErrorAlert { get }
}
