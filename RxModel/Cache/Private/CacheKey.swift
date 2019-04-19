//
//  CacheKey.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 19/10/2018.
//

import Foundation

internal class CacheKey<T>: NSObject where T: Hashable {
    // MARK: - Internal Properties
    
    internal let value: T?
    
    // MARK: - Initialization
    
    internal init(_ value: T?) {
        self.value = value
    }
    
    // MARK: - Comparation
    
    internal override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? CacheKey else {
            return false
        }
        
        guard let lhs = value, let rhs = obj.value else {
            return value == nil && obj.value == nil
        }
        
        return lhs == rhs
    }
}
