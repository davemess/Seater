//
//  BundleKey.swift
//  AppConfiguration
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// Defines constants for accessing key values from an app bundle. Cases map to key strings values.
public enum BundleKey: String {
    
    // Standard
    case bundleName = "CFBundleName"
    case bundleDisplayName = "CFBundleDisplayName"
    case bundleShortVersionString = "CFBundleShortVersionString"
    case bundleVersion = "CFBundleVersion"
    case bundleIdentifier = "CFBundleIdentifier"
    
    // User-Defined
    case configuration = "Configuration"
    case deployment = "Deployment"
    case iCloudContainerId = "iCloud Container Identifier"
    case appGroup = "App Group"
}

/// Extends Bundle with convienence functions.
public extension Bundle {
    
    subscript(_ key: BundleKey) -> String? {
        let value = object(forInfoDictionaryKey: key.rawValue) as? String
        return value
    }
}
