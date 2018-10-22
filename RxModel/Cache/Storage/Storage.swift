//
//  Storage.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 17/10/2018.
//

import Foundation
import RxSwift

public protocol Storage: class, ReactiveCompatible {
    associatedtype Key: Hashable
    associatedtype Value
    
    /// Creates an storage.
    init()
    
    /// Accesses the value for the specified key.
    subscript(key: Key) -> Value? { get set }
    
    /// Sets the value for the specified key with expiry.
    func setValue(_ value: Value?, forKey key: Key, expiry: Expiry)
        
    /// Removes all elements from the storage.
    func removeAll()
}
