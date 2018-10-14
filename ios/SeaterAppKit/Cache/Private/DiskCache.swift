//
//  DiskCache.swift
//  Cache
//
//  Created by David Messing on 10/14/18.
//

import Foundation

/// A volatile, memory cache.
class DiskCache<Key: AnyObject, Value: CodableObject>: Cache {
    
    typealias Cacheable = Value
    
    // MARK: - private properties
    
    lazy private var encoder: PropertyListEncoder = {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        return encoder
    }()
    
    lazy private var decoder: PropertyListDecoder = {
        let decoder = PropertyListDecoder()
        return decoder
    }()
    
    private let cacheName: String
    private let fileManager: FileManager = FileManager.default
    private let fileExtension = "plist"
    
    private lazy var cacheLocation: URL? = {
        if let location = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return location.appendingPathComponent(cacheName)
        }
        
        return nil
    }()
    
    // MARK: - lifecycle
    
    init(configuration: DiskConfiguration) {
        self.cacheName = configuration.cacheName
        
        if let cacheLocation = self.cacheLocation {
            try? fileManager.createDirectory(at: cacheLocation, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    // MARK: - Cache
    
    func set(_ value: Value, for key: Key) {
        guard let cacheLocation = self.cacheLocation else { return }
        
        let fileLocation = cacheLocation.appendingPathComponent("\(key)").appendingPathExtension(fileExtension)
        
        if let data = try? encoder.encode(value) {
            try? data.write(to: fileLocation)
        }
    }
    
    func removeValue(for key: Key) {
        guard let cacheLocation = self.cacheLocation else { return }
        
        let fileLocation = cacheLocation.appendingPathComponent("\(key)").appendingPathExtension(fileExtension)
        
        try? fileManager.removeItem(at: fileLocation)
    }
    
    func getValue(for key: Key) -> Value? {
        guard let cacheLocation = self.cacheLocation else { return nil }
        
        let fileLocation = cacheLocation.appendingPathComponent("\(key)").appendingPathExtension(fileExtension)
        if let data = try? Data(contentsOf: fileLocation) {
            return try? decoder.decode(Value.self, from: data)
        }
        
        return nil
    }
    
    func clear() {
        if let cacheLocation = self.cacheLocation {
            try? fileManager.removeItem(at: cacheLocation)
        }
    }
}
