//
//  Storage.swift
//  Cache
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// A concrete implementation of a storage mechanism.
public class Storage<Key: AnyObject, Value: CodableObject> {
    
    // MARK: - subscripts
    
    public subscript(key: Key) -> Value? {
        get {
            if let value = memoryCache.getValue(for: key) {
                return value
            }
            if let value = diskCache.getValue(for: key) {
                memoryCache.set(value, for: key)
                return value
            }
            
            return nil
        }
        set {
            // TODO: We shouldn't be writing to disk so often. This is a temp
            // solution to make sure we perisit data, but ideally, we only
            // write to disk in response to memory pressure notifications
            // and app background notifications.
            if let value = newValue {
                memoryCache.set(value, for: key)
                DispatchQueue.global(qos: .userInitiated).async {
                    self.diskCache.set(value, for: key)
                }
            } else {
                memoryCache.removeValue(for: key)
                DispatchQueue.global(qos: .userInitiated).async {
                    self.diskCache.removeValue(for: key)
                }
            }
        }
    }
    
    // MARK: - private properties
    
    private let memoryCache: MemoryCache<Key, Value>
    private let diskCache: DiskCache<Key, Value>
    
    // MARK: - lifecycle
    
    public convenience init(configuration: StorageConfiguration) {
        let memoryCache = MemoryCache<Key, Value>(configuration: configuration.memoryConfiguration)
        let diskCache = DiskCache<Key, Value>(configuration: configuration.diskConfiguration)
        
        self.init(memoryCache: memoryCache, diskCache: diskCache)
    }
    
    init(memoryCache: MemoryCache<Key, Value>, diskCache: DiskCache<Key, Value>) {
        self.memoryCache = memoryCache
        self.diskCache = diskCache
    }
}
