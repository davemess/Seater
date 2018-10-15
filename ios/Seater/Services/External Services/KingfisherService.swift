//
//  KingfisherService.swift
//  Seater
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation
import AppConfiguration
import Kingfisher

final class KingfisherService: ImageCacheService {
    
    private let deployment: Deployment
    
    // MARK: - lifecycle
    
    init(_ deployment: Deployment) {
        self.deployment = deployment
    }
    
    // MARK: - public
    
    func initialize(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        switch deployment {
        case .development:
            // During development, it is useful to clear the image cache to catch error states.
            ImageCache.default.clearMemoryCache()
            ImageCache.default.clearDiskCache()
        case .staging, .production:
            break
            
        }
    }
}
