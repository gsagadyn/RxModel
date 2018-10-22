//
//  Single+Append.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public extension Single {
    /// Returns Single of tuple with item.
    ///
    /// - parameters:
    ///   - item: Item to append.
    /// - returns: Observable.
    public func append<T>(weak item: T?) -> Single<(T, PrimitiveSequence.E)> {
        return self.asObservable().append(weak: item).asSingle()
    }
}
