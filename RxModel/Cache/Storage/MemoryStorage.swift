//
//  MemoryStorage.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 17/10/2018.
//

import Foundation

public final class MemoryStorage: Storage {
    public typealias Key = String
    public typealias Value = Any
    
    // MARK: - Private Properties
    
    private let cache: Cache<Key, Value>
    
    // MARK: - Initialization
    
    public required convenience init() {
        self.init(countLimit: 0)
    }
    
    public init(countLimit: Int) {
        self.cache = Cache<Key, Value>(countLimit: countLimit)
    }
}

// -----------------------------------------------------------------------------
// MARK: - Storage Access Methods
// -----------------------------------------------------------------------------

public extension MemoryStorage {
    public subscript(key: Key) -> Value? {
        get {
            return cache.value(forKey: key)
        }
        set {
            cache.setValue(newValue, forKey: key)
        }
    }
    
    public func setValue(_ value: Any?, forKey key: String, expiry: Expiry) {
        cache.setValue(value, forKey: key, expiry: expiry.date)
    }
    
    public func removeAll() {
        cache.removeAll()
    }
}
