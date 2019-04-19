//
//  Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 19/10/2018.
//

import Foundation

internal class Cache<Key, Value> where Key: Hashable {
    // MARK: - Private Properties
    
    private let queue = DispatchQueue(label: UUID().uuidString, qos: .background)
    private let cache = NSCache<CacheKey<Key>, CacheValue<Value>>()
    private var keys = Set<CacheKey<Key>>()
    
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
        var cachedValue: CacheValue<Value>?
        
        queue.sync {
            cachedValue = cache.object(forKey: CacheKey(key))
        }
        
        if cachedValue?.isExpired ?? false {
            removeValue(forKey: key)
        }
        
        return cachedValue?.value
    }
    
    internal func setValue(_ value: Value?, forKey key: Key, cost: Int = 0, expiry: Date? = nil) {
        guard let value = value else {
            removeValue(forKey: key)
            return
        }
        
        queue.sync {
            cache.setObject(CacheValue(value, expiry: expiry), forKey: CacheKey(key), cost: cost)
            keys.insert(CacheKey(key))
        }
    }
    
    internal func removeValue(forKey key: Key) {
        queue.sync {
            cache.removeObject(forKey: CacheKey(key))
            keys.remove(CacheKey(key))
        }
    }
    
    internal func removeAll() {
        queue.sync {
            cache.removeAllObjects()
            keys.removeAll()
        }
    }
    
    internal func allKeys() -> [Key] {
        return Array(keys).compactMap { $0.value }
    }
}
