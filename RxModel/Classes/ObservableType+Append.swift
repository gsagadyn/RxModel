//
//  ObservableType+JSONDecoder.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public enum RxRuntimeError: Error {
    case itemMissing
}

public extension ObservableType {
    /// Returns Observable of tuple with item.
    ///
    /// - parameters:
    ///   - item: Item to append.
    /// - returns: Observable.
    public func append<T>(weak item: T?) -> Observable<(T, Self.E)> {
        return map {
            guard let item = item else { throw RxRuntimeError.itemMissing }
            return (item, $0)
        }
    }
}
