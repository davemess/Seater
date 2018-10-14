//
//  NetworkIndicatorManager.swift
//  AppUI
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// A manager for controlling the application network activity indicator.
public class NetworkIndicatorManager {
    
    static private let MinimumActivityCount = 0
    static private let DelayInterval: DispatchTimeInterval = .milliseconds(250)
    
    public static let shared = NetworkIndicatorManager()
    private var activityCount = MinimumActivityCount
    
    public var visible: Bool = false {
        didSet {
            if visible {
                activityCount += 1
            } else {
                activityCount -= 1
            }
            
            //assert(activityCount >= NetworkIndicatorManager.MinimumActivityCount)
            if activityCount < 0 { activityCount = 0 }
            
            let delay: DispatchTime = DispatchTime.now() + NetworkIndicatorManager.DelayInterval
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = (self.activityCount > 0)
            })
        }
    }
    
    // MARK: - lifecycle
    
    private init() {}
}
