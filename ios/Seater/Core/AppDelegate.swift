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
    private let appFactory: AppFactory
    
    // View heirarchy
    var window: UIWindow?
    
    // Util
    private let log = AppLogger.log(.core)
    
    // MARK: - lifecycle
    
    override init() {
        guard let buildConfiguration = BuildConfiguration(bundle: Bundle.main) else { preconditionFailure("BuildConfiguration could not be assessed.") }
        
        self.buildConfiguration = buildConfiguration
        let appServices = AppServices(self.buildConfiguration)
        self.appFactory = AppFactory(appServices)
        
        super.init()
    }
    
    // MARK: - application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize services
        initializeLaunchServices(appFactory.launchServices, launchOptions: launchOptions)
        
        os_log("didFinishLaunchingWithOptions with configuration %{public}@ and launchOptions: %{public}@", log: log, type: .info, buildConfiguration.description, launchOptions ?? "[]")
        
        return true
    }
    
    // MARK: - private app initialization
    
    private func initializeLaunchServices(_ launchServices: [LaunchService], launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        launchServices.forEach { (service) in
            service.initialize(launchOptions)
        }
    }

}
