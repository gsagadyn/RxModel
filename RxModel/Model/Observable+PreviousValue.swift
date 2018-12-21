//
//  Observable+ModelValidate.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public extension ObservableType {
    
    /// Combines previus and current sequence value.
    ///
    /// - parameters:
    ///   - startWith: Element to prepend to the specified sequence
    /// - returns: Observable.
    public func withPrevious(startWith value: E) -> Observable<(E, E)> {
        return scan((value, value), accumulator: { ($0.1, $1) }).skip(1)
    }
    
}
