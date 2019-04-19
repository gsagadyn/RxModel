//
//  Single+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension PrimitiveSequence where TraitType == SingleTrait {
    public func cached<T>(forType type: T, identifier: String? = nil, expiry: Expiry = .never) -> Single<ElementType> {
        return asObservable().cached(forType: type, identifier: identifier, expiry: expiry).asSingle()
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Single<ElementType> {
        return asObservable().cached(forKey: key, expiry: expiry).asSingle()
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, identifier: String? = nil, expiry: Expiry = .never) -> Single<ElementType> where S.Key == String {
        return asObservable().cached(on: storage, forType: type, identifier: identifier, expiry: expiry).asSingle()
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Single<ElementType> {
        return asObservable().cached(on: storage, forKey: key, expiry: expiry).asSingle()
    }
    
    public func removeCachedValue<T>(forType type: T, identifier: String? = nil) -> Single<ElementType> {
        return asObservable().removeCachedValue(forType: type, identifier: identifier).asSingle()
    }
    
    public func removeCachedValue(forKey key: String) -> Single<ElementType> {
        return asObservable().removeCachedValue(forKey: key).asSingle()
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T, identifier: String? = nil) -> Single<ElementType> where S.Key == String {
        return asObservable().removeCachedValue(from: storage, forType: type, identifier: identifier).asSingle()
    }
    
    public func removeCachedValue<S: Storage>(from storage: S, forKey key: S.Key) -> Single<ElementType> {
        return asObservable().removeCachedValue(from: storage, forKey: key).asSingle()
    }
    
    public func removeAllCachedValues() -> Single<ElementType> {
        return asObservable().removeAllCachedValues().asSingle()
    }
    
    public func removeAllCachedValues<S: Storage>(from storage: S) -> Single<ElementType> {
        return asObservable().removeAllCachedValues(from: storage).asSingle()
    }
}
