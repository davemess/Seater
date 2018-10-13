//
//  CrashlyticsService.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppConfiguration
import Fabric
import Crashlytics

/// Enacapsulates configuration of a Crashlytics service.
class CrashlyticsService: LaunchService {
    
    // MARK: - lifecycle
    
    init(_ deployment: Deployment) {
        switch deployment {
        case .development, .staging, .production:
            Fabric.sharedSDK().debug = false
        }
    }
    
    // MARK: - public
    
    func initialize(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        Fabric.with([Crashlytics.self])
    }
    
}
