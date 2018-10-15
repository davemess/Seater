//
//  AppDelegate.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
import SeaterKit
import AppConfiguration
import AppAnalytics
import AppTheme
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Core components
    private let appFactory: AppFactory
    
    // View heirarchy
    var window: UIWindow?
    private var rootCoordinator: NavigationCoordinator
    
    // Util
    private let log = AppLogger.log(.core)
    
    // MARK: - lifecycle
    
    override init() {
        guard let buildConfiguration = BuildConfiguration(bundle: Bundle.main) else { preconditionFailure("BuildConfiguration could not be assessed.") }
        
        // Core components
        let appServices = AppServices(buildConfiguration)
        self.appFactory = AppFactory(appServices)
        
        // View heirarchy
        let screenFrame = UIScreen.main.bounds
        self.window = UIWindow(frame: screenFrame)
        
        let rootController: UINavigationController = UINavigationController()
        self.rootCoordinator = self.appFactory.rootCoordinator(with: rootController)
        
        super.init()        
    }
    
    // MARK: - application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize services
        initializeLaunchServices(appFactory.launchServices, launchOptions: launchOptions)
        initializeAnalytics()
        initializeApplicationTheme()
        initializeSeaterKit()
        
        presentKeyWindow(false)
        
        AnalyticsManager.shared.log(SeaterAnalyticEvent.appLaunch.toAnalyticEvent())
        os_log("didFinishLaunchingWithOptions with launchOptions: %{public}@", log: log, type: .info, launchOptions ?? "[]")
        
        return true
    }
    
    // MARK: - private app initialization
    
    private func initializeLaunchServices(_ launchServices: [LaunchService], launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        launchServices.forEach { (service) in
            service.initialize(launchOptions)
        }
    }

    private func initializeAnalytics() {
        let recorder = appFactory.analyticsRecorder
        AnalyticsManager.shared.register(recorder)
    }
    
    private func initializeApplicationTheme() {
        let theme = appFactory.applicationTheme
        AppearanceThemeManager.theme = theme
    }
    
    private func initializeSeaterKit() {
        let serviceProvider: SeaterKitServiceProvider = appFactory.seaterKitServiceProvider
        SeaterKit.initialize(with: serviceProvider)
    }
    
    private func presentKeyWindow(_ animated: Bool = false) {
        window?.rootViewController = rootCoordinator.navigationController
        window?.makeKeyAndVisible()
        rootCoordinator.start(animated)
    }
}
