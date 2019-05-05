//
//  Maybe+Append.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension Maybe {
    /// Returns Single of tuple with item.
    ///
    /// - parameters:
    ///   - item: Item to append.
    /// - returns: Observable.
    public func append<T>(weak item: T?) -> Maybe<(T, PrimitiveSequence.Element)> {
        return self.asObservable().append(weak: item).asMaybe()
    }
}
