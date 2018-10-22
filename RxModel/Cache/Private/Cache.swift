//
//  Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 19/10/2018.
//

import Foundation

internal class Cache<Key, Value> where Key: Hashable {
    // MARK: - Private Properties
    
    private let cache = NSCache<CacheKey<Key>, CacheValue<Value>>()
    
    // MARK: - Internal Properties
    
    internal var name: String {
        get {
            return cache.name
        }
        set {
            cache.name = newValue
        }
    }
    internal var countLimit: Int {
        get {
            return cache.countLimit
        }
        set {
            cache.countLimit = newValue
        }
    }
    internal var totalCostLimit: Int {
        get {
            return cache.totalCostLimit
        }
        set {
            cache.totalCostLimit = newValue
        }
    }
    internal var evictsObjectsWithDiscardedContent: Bool {
        get {
            return cache.evictsObjectsWithDiscardedContent
        }
        set {
            cache.evictsObjectsWithDiscardedContent = newValue
        }
    }
    internal var delegate: NSCacheDelegate? {
        get {
            return cache.delegate
        }
        set {
            cache.delegate = newValue
        }
    }
    
    // MARK: - Initialization
    
    internal init(countLimit: Int = 0, totalCostLimit: Int = 0) {
        self.cache.countLimit = countLimit
        self.cache.totalCostLimit = totalCostLimit
    }
    
    // MARK: - Access Methods
    
    internal func value(forKey key: Key) -> Value? {
        let cachedValue = cache.object(forKey: CacheKey(key))
        
        if cachedValue?.isExpired ?? false {
            removeValue(forKey: key)
        }
        
        return cachedValue?.value
    }
    
    internal func setValue(_ value: Value?, forKey key: Key, cost: Int = 0, expiry: Date? = nil) {
        if let value = value {
            cache.setObject(CacheValue(value, expiry: expiry), forKey: CacheKey(key), cost: cost)
        } else {
            removeValue(forKey: key)
        }
    }
    
    internal func removeValue(forKey key: Key) {
        cache.removeObject(forKey: CacheKey(key))
    }
    
    internal func removeAll() {
        cache.removeAllObjects()
    }
}
