//
//  AppFactory.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit

/// Core factory for producing components necessary for app launch and run.
class AppFactory {

    // MARK: - private properties
    
    private let appServices: AppServices
    
    // MARK: - public properties
    
    var launchServices: [LaunchService] {
        // swiftlint:disable force_cast
        let launchServices = appServices.services.filter { $0 is LaunchService }
        return launchServices as! [LaunchService]
        // swiftlint:enable force_cast
    }
    
    // MARK: - lifecyle
    
    init(_ appServices: AppServices) {
        self.appServices = appServices
    }
}
