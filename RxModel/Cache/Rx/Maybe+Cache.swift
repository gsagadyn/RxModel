//
//  Maybe+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension Maybe {
    public func cached<T>(forType type: T, expiry: Expiry = .never) -> Maybe<E> {
        return asObservable().cached(forType: type, expiry: expiry).asMaybe()
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Maybe<E> {
        return asObservable().cached(forKey: key, expiry: expiry).asMaybe()
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, expiry: Expiry = .never) -> Maybe<E> where S.Key == String {
        return asObservable().cached(on: storage, forType: type, expiry: expiry).asMaybe()
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Maybe<E> {
        return asObservable().cached(on: storage, forKey: key, expiry: expiry).asMaybe()
    }
    
    public func removeCachedValue<T>(forType type: T) -> Maybe<E> {
        return asObservable().removeCachedValue(forType: type).asMaybe()
    }
    
    public func removeCachedValue(forKey key: String) -> Maybe<E> {
        return asObservable().removeCachedValue(forKey: key).asMaybe()
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T) -> Maybe<E> where S.Key == String {
        return asObservable().removeCachedValue(from: storage, forType: type).asMaybe()
    }
    
    public func removeCachedValue<S: Storage>(from storage: S, forKey key: S.Key) -> Maybe<E> {
        return asObservable().removeCachedValue(from: storage, forKey: key).asMaybe()
    }
}
