//
//  Single+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

public extension Single {
    public func cached(forKey key: String, expiry: Expiry = .never) -> Single<E> {
        return asObservable().cached(forKey: key, expiry: expiry).asSingle()
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Single<E> {
        return asObservable().cached(on: storage, forKey: key, expiry: expiry).asSingle()
    }
}
