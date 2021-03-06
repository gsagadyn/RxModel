//
//  Single+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension PrimitiveSequence where Trait == SingleTrait {
    public func cached<T>(forType type: T, expiry: Expiry = .never) -> Single<Element> {
        return asObservable().cached(forType: type, expiry: expiry).asSingle()
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Single<Element> {
        return asObservable().cached(forKey: key, expiry: expiry).asSingle()
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, expiry: Expiry = .never) -> Single<Element> where S.Key == String {
        return asObservable().cached(on: storage, forType: type, expiry: expiry).asSingle()
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Single<Element> {
        return asObservable().cached(on: storage, forKey: key, expiry: expiry).asSingle()
    }
    
    public func removeCachedValue<T>(forType type: T) -> Single<Element> {
        return asObservable().removeCachedValue(forType: type).asSingle()
    }
    
    public func removeCachedValue(forKey key: String) -> Single<Element> {
        return asObservable().removeCachedValue(forKey: key).asSingle()
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T) -> Single<Element> where S.Key == String {
        return asObservable().removeCachedValue(from: storage, forType: type).asSingle()
    }
    
    public func removeCachedValue<S: Storage>(from storage: S, forKey key: S.Key) -> Single<Element> {
        return asObservable().removeCachedValue(from: storage, forKey: key).asSingle()
    }
    
    public func removeAllCachedValues() -> Single<Element> {
        return asObservable().removeAllCachedValues().asSingle()
    }
    
    public func removeAllCachedValues<S: Storage>(from storage: S) -> Single<Element> {
        return asObservable().removeAllCachedValues(from: storage).asSingle()
    }
}
