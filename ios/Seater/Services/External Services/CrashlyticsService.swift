//
//  CrashlyticsService.swift
//  Seater
//
//  Created by David Messing on 10/13/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppConfiguration
import AppAnalytics
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

extension CrashlyticsService: AnalyticsService {
    
    func analyticsRecorder() -> AnalyticsRecorder {
        return AnswersAnalyticsRecorder()
    }
}

/// A custom AnalyticsRecorder configured to record with the Answers service.
class AnswersAnalyticsRecorder: AnalyticsRecorder {
    
    func record(_ event: AnalyticEvent) {
        switch event {
        case let .contentView(name, contentType, contentId, attributes):
            Answers.logContentView(withName: name, contentType: contentType, contentId: contentId, customAttributes: attributes)
            
        case let .share(method, name, contentType, contentId, attributes):
            Answers.logShare(withMethod: method, contentName: name, contentType: contentType, contentId: contentId, customAttributes: attributes)
            
        case let .custom(name, attributes):
            Answers.logCustomEvent(withName: name, customAttributes: attributes)
        }
    }
}
