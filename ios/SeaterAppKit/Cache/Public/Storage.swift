//
//  Storage.swift
//  Cache
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// A concrete implementation of a storage mechanism.
public class Storage<Key: AnyObject, Value: AnyObject> {
    
    // MARK: - subscripts
    
    public subscript(key: Key) -> Value? {
        get {
            return memoryCache.getValue(for: key)
        }
        set {
            memoryCache.set(newValue, for: key)
        }
    }
    
    // MARK: - private properties
    
    private let memoryCache: MemoryCache<Key, Value>
    
    // MARK: - lifecycle
    
    public init(configuration: StorageConfiguration) {
        self.memoryCache = MemoryCache(configuration: configuration.memoryConfiguration)
        self.registerNotifications()
    }
    
    // MARK: - notifications
    
    private func registerNotifications(_ notificationCenter: NotificationCenter = .default) {
//        notificationCenter.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
}
