//
//  Observable+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension Observable {
    public func cached<T>(forType type: T, expiry: Expiry = .never) -> Observable<Element> {
        return cached(on: MemoryStorage.shared, forType: type, expiry: expiry)
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Observable<Element> {
        return cached(on: MemoryStorage.shared, forKey: key, expiry: expiry)
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, expiry: Expiry = .never) -> Observable<Element> where S.Key == String {
        return cached(on: storage, forKey: String(describing: type), expiry: expiry)
    }
    
    public func cached<S: Storage>(on storage: S, forKey key: S.Key, expiry: Expiry = .never) -> Observable<Element> {
        return Observable<Element>.deferred { () -> Observable<Element> in
            guard let value = storage[key] as? Element else {
                return self.do(onNext: { storage.setValue($0 as? S.Value, forKey: key, expiry: expiry) })
            }
            return .just(value)
        }
    }
    
    public func removeCachedValue<T>(forType type: T) -> Observable<Element> {
        return removeCachedValue(from: MemoryStorage.shared, forType: type)
    }
    
    public func removeCachedValue(forKey key: String) -> Observable<Element> {
        return removeCachedValue(from: MemoryStorage.shared, forKey: key)
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T) -> Observable<Element> where S.Key == String {
        return removeCachedValue(forKey: String(describing: type))
    }
    
    public func removeCachedValue<S: Storage>(from storage: S, forKey key: S.Key) -> Observable<Element> {
        return self.flatMap { storage.rx.removeValue(forKey: key).andThen(Observable.just($0)) }
    }
    
    public func removeAllCachedValues() -> Observable<Element> {
        return removeAllCachedValues(from: MemoryStorage.shared)
    }
    
    public func removeAllCachedValues<S: Storage>(from storage: S) -> Observable<Element> {
        return self.flatMap { storage.rx.removeAll().andThen(Observable.just($0)) }
    }
}
