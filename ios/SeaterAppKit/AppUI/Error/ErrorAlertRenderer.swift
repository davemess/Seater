//
//  ErrorAlertRenderer.swift
//  AppUI
//
//  Created by David Messing on 10/13/18.
//

import UIKit

/// Defines a methods for presenting errors.
public protocol ErrorAlertRenderer {
    func present(_ error: Error)
    func present(_ errorAlert: ErrorAlert)
}

/// Protocol extension for view controllers to present errors.
public extension ErrorAlertRenderer where Self: UIViewController {
    
    private var okAction: UIAlertAction {
        let title = NSLocalizedString("Ok", comment: "")
        let okAction = UIAlertAction(title: title, style: .default, handler: nil)
        
        return okAction
    }
    
    func present(_ error: Error) {
        if let error = error as? ErrorAlertConvertible {
            let errorAlert = error.errorAlert
            present(errorAlert)
        } else if let error = error as? LocalizedError, let errorDescription = error.errorDescription {
            let errorAlert = ErrorAlert(message: errorDescription)
            present(errorAlert)
        } else {
            let error = error as NSError
            let errorAlert = ErrorAlert(message: error.localizedDescription)
            present(errorAlert)
        }
    }
    
    func present(_ errorAlert: ErrorAlert) {
        let alertController = UIAlertController(title: errorAlert.title, message: errorAlert.message, preferredStyle: .alert)
        
        if let actions = errorAlert.actions, actions.isEmpty == false {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            let action = okAction
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
