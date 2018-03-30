//
//  Observable+JSONDecoder.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public extension Observable {
    public enum RuntimeError: Error {
        case itemMissing
    }
    
    /// Returns Observable of tuple with item.
    ///
    /// - parameters:
    ///   - item: Item to append.
    /// - returns: Observable.
    public func append<T>(weak item: T?) -> Observable<(T, Observable.E)> {
        return map {
            guard let item = item else { throw RuntimeError.itemMissing }
            return (item, $0)
        }
    }
}
