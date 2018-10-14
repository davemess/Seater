//
//  MemoryCache.swift
//  Cache
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// A volatile, memory cache.
class MemoryCache<Key: AnyObject, Value: AnyObject>: NSObject, NSCacheDelegate, Cache {
    
    typealias Cacheable = Value
    
    // MARK: - private properties
    
    private let cache: NSCache<Key, Value>
    
    // MARK: - lifecycle
    
    init(configuration: MemoryConfiguration) {
        self.cache = NSCache()
        self.cache.countLimit = configuration.maxCount
        
        super.init()
        
        self.cache.delegate = self
    }
    
    // MARK: - CacheType
    
    func set(_ value: Value?, for key: Key) {
        if let value = value {
            cache.setObject(value, forKey: key)
        } else {
            cache.removeObject(forKey: key)
        }
    }
    
    func getValue(for key: Key) -> Value? {
        return cache.object(forKey: key)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
    
    // MARK: - NSCacheDelegate
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        //        <#code#>
    }
}
