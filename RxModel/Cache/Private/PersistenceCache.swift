//
//  PersistenceCache.swift
//  RxModel
//
//  Created by Michał Wąsowicz on 02/09/2021.
//

import Foundation

internal class PersistenceCache<Key, Value> where Key: Hashable {
    // MARK: - Private Properties
    
    private let queue = DispatchQueue(label: UUID().uuidString, qos: .background)
    private var cache = [CacheKey<Key>: CacheValue<Value>]()
    private var keys = Set<CacheKey<Key>>()
    
    // MARK: - Access Methods
    
    internal func value(forKey key: Key) -> Value? {
        var cachedValue: CacheValue<Value>?
        
        queue.sync {
            cachedValue = cache[CacheKey(key)]
        }
        
        if cachedValue?.isExpired ?? false {
            removeValue(forKey: key)
        }
        
        return cachedValue?.value
    }
    
    internal func setValue(_ value: Value?, forKey key: Key, expiry: Date? = nil) {
        guard let value = value else {
            removeValue(forKey: key)
            return
        }
        
        queue.sync {
            cache[CacheKey(key)] = CacheValue(value, expiry: expiry)
            keys.insert(CacheKey(key))
        }
    }
    
    internal func removeValue(forKey key: Key) {
        queue.sync {
            cache.removeValue(forKey: CacheKey(key))
            keys.remove(CacheKey(key))
        }
    }
    
    internal func removeAll() {
        queue.sync {
            cache.removeAll()
            keys.removeAll()
        }
    }
    
    internal func allKeys() -> [Key] {
        return Array(keys).compactMap { $0.value }
    }
}
