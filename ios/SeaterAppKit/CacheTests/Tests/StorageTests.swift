//
//  StorageTests.swift
//  CacheTests
//
//  Created by David Messing on 10/15/18.
//

import XCTest
@testable import Cache

class StorageTests: XCTestCase {

    func testReadsFromMemoryCacheIfValuePresent() {
        let mockValue = MockCodable()
        let memoryConfiguration = MemoryConfiguration(maxCount: 0)
        let memoryCache = MockMemoryCache<NSString, MockCodable>(configuration: memoryConfiguration, value: mockValue)
        
        let diskConfiguration = DiskConfiguration(cacheName: "mock")
        let diskCache = MockDiskCache<NSString, MockCodable>(configuration: diskConfiguration, value: mockValue)
        
        let storage = Storage<NSString, MockCodable>(memoryCache: memoryCache, diskCache: diskCache)
        let _ = storage["test"]
        
        XCTAssertTrue(memoryCache.didReturnValue)
        XCTAssertFalse(diskCache.didReturnValue)
    }
    
    func testReadsFromDiskCacheIfValueNotPresentInMemory() {
        let mockValue = MockCodable()
        let memoryConfiguration = MemoryConfiguration(maxCount: 0)
        let memoryCache = MockMemoryCache<NSString, MockCodable>(configuration: memoryConfiguration, value: nil)
        
        let diskConfiguration = DiskConfiguration(cacheName: "mock")
        let diskCache = MockDiskCache<NSString, MockCodable>(configuration: diskConfiguration, value: mockValue)
        
        let storage = Storage<NSString, MockCodable>(memoryCache: memoryCache, diskCache: diskCache)
        let _ = storage["test"]
        
        XCTAssertFalse(memoryCache.didReturnValue)
        XCTAssertTrue(diskCache.didReturnValue)
    }

}

class MockMemoryCache<Key: AnyObject, Value: CodableObject>: MemoryCache<NSString, MockCodable> {
    
    let value: MockCodable?
    var didReturnValue: Bool = false
    
    init(configuration: MemoryConfiguration, value: MockCodable?) {
        self.value = value
        super.init(configuration: configuration)
    }
    
    override func getValue(for key: NSString) -> MockCodable? {
        didReturnValue = (value != nil)
        return value
    }
}

class MockDiskCache<Key: AnyObject, Value: CodableObject>: DiskCache<NSString, MockCodable> {
    
    let value: MockCodable?
    var didReturnValue: Bool = false
    
    init(configuration: DiskConfiguration, value: MockCodable?) {
        self.value = value
        super.init(configuration: configuration)
    }
    
    override func getValue(for key: NSString) -> MockCodable? {
        didReturnValue = true
        return value
    }
}

class MockCodable: Codable {
    
    init() {}
}
