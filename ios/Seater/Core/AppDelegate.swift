//
//  AppDelegate.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import UIKit
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
    private let rootController: UINavigationController = UINavigationController()
    private var rootCoordinator: NavigationCoordinator
    
    // Util
    private let log = AppLogger.log(.core)
    
    // MARK: - lifecycle
    
    override init() {
        guard let buildConfiguration = BuildConfiguration(bundle: Bundle.main) else { preconditionFailure("BuildConfiguration could not be assessed.") }
        
        // Core components
        let appServiceProvider: AppServiceProvider = AppServices(buildConfiguration)
        self.appFactory = AppFactory(appServiceProvider)
        
        // View heirarchy
        let screenFrame = UIScreen.main.bounds
        self.window = UIWindow(frame: screenFrame)
        self.window?.rootViewController = self.rootController
        self.rootCoordinator = self.appFactory.rootCoordinator(with: rootController)
        
        super.init()
        
        os_log("%{public}@ did init with configuration %{public}@ and launchOptions: %{public}@", log: log, type: .info, self, buildConfiguration.description)
    }
    
    // MARK: - application lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize services
        initializeLaunchServices(appFactory.launchServices, launchOptions: launchOptions)
        initializeAnalytics()
        initializeApplicationTheme()
        
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
    
    private func presentKeyWindow(_ animated: Bool = false) {
        window?.makeKeyAndVisible()
        rootCoordinator.start(animated)
    }
}
