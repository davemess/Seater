//
//  Cache.swift
//  Cache
//
//  Created by David Messing on 10/14/18.
//

import Foundation

public typealias CodableObject = (AnyObject & Codable)

/// Describes a protocol for conforming classes to adopt in order to support
/// high-level caching operations.
public protocol Cache {
    
    associatedtype Value
    associatedtype Key = String
    
    func set(_ value: Value, for key: Key)
    func removeValue(for key: Key)
    func getValue(for key: Key) -> Value?
    func clear()
}

/// Wraps configuration parameters for a MemoryCache.
public struct MemoryConfiguration {
    public static let `default`: MemoryConfiguration = MemoryConfiguration(maxCount: 1000)
    
    public let maxCount: Int
}

/// Wraps configuration parameters for a DiskCache.
public struct DiskConfiguration {
    public static let `default`: DiskConfiguration = DiskConfiguration(cacheName: "caches")
    
    public let cacheName: String
}

/// Wraps configuration parameters for a Storage object.
public struct StorageConfiguration {
    public static let `default`: StorageConfiguration = StorageConfiguration(memoryConfiguration: .default, diskConfiguration: .default)
    
    public let memoryConfiguration: MemoryConfiguration
    public let diskConfiguration: DiskConfiguration
}
