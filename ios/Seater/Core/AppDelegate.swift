//
//  AppDelegate.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import AppConfiguration
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Core components
    private let buildConfiguration: BuildConfiguration
    
    // View heirarchy
    var window: UIWindow?
    
    // Util
    private let log = AppLogger.log(.core)
    
    // MARK: - lifecycle
    
    override init() {
        guard let buildConfiguration = BuildConfiguration(bundle: Bundle.main) else { preconditionFailure("BuildConfiguration could not be assessed.") }
        
        self.buildConfiguration = buildConfiguration
        
        super.init()
    }
    
    // MARK: - application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        os_log("didFinishLaunchingWithOptions with configuration %{public}@ and launchOptions: %{public}@", log: log, type: .info, buildConfiguration.description, launchOptions ?? "[]")
        
        return true
    }

}
