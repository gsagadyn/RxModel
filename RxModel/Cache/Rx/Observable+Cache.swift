//
//  Observable+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension Observable {
    public func cached<T>(forType type: T, expiry: Expiry = .never) -> Observable<E> {
        return cached(on: MemoryStorage.shared, forType: type, expiry: expiry)
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Observable<E> {
        return cached(on: MemoryStorage.shared, forKey: key, expiry: expiry)
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, expiry: Expiry = .never) -> Observable<E> where S.Key == String {
        return cached(on: storage, forKey: String(describing: type), expiry: expiry)
    }
    
    public func cached<S: Storage>(on storage: S, forKey key: S.Key, expiry: Expiry = .never) -> Observable<E> {
        return Observable<E>.deferred { () -> Observable<Element> in
            if let value = storage[key] as? E {
                return .just(value)
            } else {
                return self.do(onNext: { storage.setValue($0 as? S.Value, forKey: key, expiry: expiry) })
            }
        }
    }
    
    public func removeCachedValue<T>(forType type: T) -> Observable<E> {
        return removeCachedValue(from: MemoryStorage.shared, forType: type)
    }
    
    public func removeCachedValue(forKey key: String) -> Observable<E> {
        return removeCachedValue(from: MemoryStorage.shared, forKey: key)
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T) -> Observable<E> where S.Key == String {
        return self.flatMap { storage.rx.removeValue(forKey: String(describing: type)).andThen(Observable.just($0)) }
    }
    
    public func removeCachedValue<S: Storage>(from storage: S, forKey key: S.Key) -> Observable<E> {
        return self.flatMap { storage.rx.removeValue(forKey: key).andThen(Observable.just($0)) }
    }
    
    public func removeAllCachedValues() -> Observable<E> {
        return removeAllCachedValues(from: MemoryStorage.shared)
    }
    
    public func removeAllCachedValues<S: Storage>(from storage: S) -> Observable<E> {
        return self.flatMap { storage.rx.removeAll().andThen(Observable.just($0)) }
    }
}
