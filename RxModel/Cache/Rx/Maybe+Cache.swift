//
//  Maybe+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension Maybe {
    public func cached(forKey key: String, expiry: Expiry = .never) -> Maybe<E> {
        return asObservable().cached(forKey: key, expiry: expiry).asMaybe()
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Maybe<E> {
        return asObservable().cached(on: storage, forKey: key, expiry: expiry).asMaybe()
    }
}
