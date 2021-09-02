//
//  SimpleStorage.swift
//  RxModel
//
//  Created by Michał Wąsowicz on 02/09/2021.
//

import Foundation

public final class SimpleStorage: Storage {
    public typealias Key = String
    public typealias Value = Any
    
    // MARK: - Private Properties
    
    private let cache: PersistenceCache<Key, Value>
    
    // MARK: - Initialization
    
    public required init() {
        self.cache = PersistenceCache<Key, Value>()
    }
}

// -----------------------------------------------------------------------------
// MARK: - Storage Access Methods
// -----------------------------------------------------------------------------

extension SimpleStorage {
    public subscript(key: Key) -> Value? {
        get { return cache.value(forKey: key) }
        set { cache.setValue(newValue, forKey: key) }
    }
    
    public func setValue(_ value: Any?, forKey key: String, expiry: Expiry) {
        cache.setValue(value, forKey: key, expiry: expiry.date)
    }
    
    public func removeValue(forKey key: String) {
        cache.removeValue(forKey: key)
    }
    
    public func removeAll() {
        cache.removeAll()
    }
    
    public func allKeys() -> [Key] {
        return cache.allKeys()
    }
}
