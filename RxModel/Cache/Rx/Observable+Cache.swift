//
//  Observable+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

public extension Observable {
    public func cached(forKey key: String, expiry: Expiry = .never) -> Observable<E> {
        return cached(on: MemoryStorage.shared, forKey: key, expiry: expiry)
    }
    
    public func cached<T: Storage>(on storage: T, forKey key: T.Key, expiry: Expiry = .never) -> Observable<E> {
        return Observable<E>.deferred { () -> Observable<Element> in
            if let value = storage[key] as? E {
                return .just(value)
            } else {
                return self.do(onNext: { storage.setValue($0 as? T.Value, forKey: key, expiry: expiry) })
            }
        }
    }
}
