//
//  CacheValue.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 19/10/2018.
//

import Foundation

internal class CacheValue<T> {
    // MARK: - Internal Properties
    
    internal var value: T? {
        return isExpired ? nil : cachedValue
    }
    internal var isExpired: Bool {
        return expiry.map { $0 < Date() } ?? false
    }
    
    // MARK: - Private Properties
    
    private let cachedValue: T?
    private let expiry: Date?
    
    // MARK: - Initialization
    
    internal init(_ value: T?, expiry: Date?) {
        self.cachedValue = value
        self.expiry = expiry
    }
}
