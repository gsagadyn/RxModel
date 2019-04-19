//
//  Observable+Cache.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 22/10/2018.
//

import RxSwift

extension Observable {
    public func cached<T>(forType type: T, identifier: String? = nil, expiry: Expiry = .never) -> Observable<E> {
        return cached(on: MemoryStorage.shared, forType: type, identifier: identifier, expiry: expiry)
    }
    
    public func cached(forKey key: String, expiry: Expiry = .never) -> Observable<E> {
        return cached(on: MemoryStorage.shared, forKey: key, expiry: expiry)
    }
    
    public func cached<T, S: Storage>(on storage: S, forType type: T, identifier: String? = nil, expiry: Expiry = .never) -> Observable<E> where S.Key == String {
        let key = "\(String(describing: type))#\(identifier ?? "")"
        return cached(on: storage, forKey: key, expiry: expiry)
    }
    
    public func cached<S: Storage>(on storage: S, forKey key: S.Key, expiry: Expiry = .never) -> Observable<E> {
        return Observable<E>.deferred { () -> Observable<Element> in
            guard let value = storage[key] as? E else {
                return self.do(onNext: { storage.setValue($0 as? S.Value, forKey: key, expiry: expiry) })
            }
            return .just(value)
        }
    }
    
    public func removeCachedValue<T>(forType type: T, identifier: String? = nil) -> Observable<E> {
        return removeCachedValue(from: MemoryStorage.shared, forType: type, identifier: identifier)
    }
    
    public func removeCachedValue(forKey key: String) -> Observable<E> {
        return removeCachedValue(from: MemoryStorage.shared, forKey: key)
    }
    
    public func removeCachedValue<T, S: Storage>(from storage: S, forType type: T, identifier: String? = nil) -> Observable<E> where S.Key == String {
        let key = "\(String(describing: type))#\(identifier ?? "")"
        let keys = identifier == nil ? storage.allKeys().filter { $0.hasPrefix(key) } : [key]
        let completable = keys.reduce(Completable.empty(), { $0.andThen(storage.rx.removeValue(forKey: $1)) })
        return self.flatMap { completable.andThen(Observable.just($0)) }
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
