//
//  Maybe+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension PrimitiveSequence where Trait == MaybeTrait {
    public func cached<T>(forType type: T, expiry: Expiry = .never) -> Maybe<Element> {
        return asObservable().cached(forType: type, expiry: expiry).asMaybe()
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Maybe<Element> {
        return asObservable().cached(forKey: key, expiry: expiry).asMaybe()
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, expiry: Expiry = .never) -> Maybe<Element> where S.Key == String {
        return asObservable().cached(on: storage, forType: type, expiry: expiry).asMaybe()
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Maybe<Element> {
        return asObservable().cached(on: storage, forKey: key, expiry: expiry).asMaybe()
    }
    
    public func removeCachedValue<T>(forType type: T) -> Maybe<Element> {
        return asObservable().removeCachedValue(forType: type).asMaybe()
    }
    
    public func removeCachedValue(forKey key: String) -> Maybe<Element> {
        return asObservable().removeCachedValue(forKey: key).asMaybe()
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T) -> Maybe<Element> where S.Key == String {
        return asObservable().removeCachedValue(from: storage, forType: type).asMaybe()
    }
    
    public func removeCachedValue<S: Storage>(from storage: S, forKey key: S.Key) -> Maybe<Element> {
        return asObservable().removeCachedValue(from: storage, forKey: key).asMaybe()
    }
    
    public func removeAllCachedValues() -> Maybe<Element> {
        return asObservable().removeAllCachedValues().asMaybe()
    }
    
    public func removeAllCachedValues<S: Storage>(from storage: S) -> Maybe<Element> {
        return asObservable().removeAllCachedValues(from: storage).asMaybe()
    }
}
