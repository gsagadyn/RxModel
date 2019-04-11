//
//  Storage+Rx.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 19/10/2018.
//

import RxSwift

extension Reactive where Base: Storage {
    public func value(forKey key: Base.Key) -> Single<Base.Value?> {
        return .deferred { [weak base] in
            return .just(base?[key])
        }
    }
    
    public func setValue(_ value: Base.Value?, forKey key: Base.Key, expiry: Expiry = .never) -> Completable {
        return .deferred { [weak base] in
            base?.setValue(value, forKey: key, expiry: expiry)
            return .empty()
        }
    }
    
    public func removeValue(forKey key: Base.Key) -> Completable {
        return .deferred { [weak base] in
            base?.removeValue(forKey: key)
            return .empty()
        }
    }
    
    public func removeAll() -> Completable {
        return .deferred { [weak base] in
            base?.removeAll()
            return .empty()
        }
    }
}
