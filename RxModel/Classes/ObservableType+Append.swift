//
//  ObservableType+Append.swift
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
        let observable: Observable<(T?, Self.E)>
        
        if let item = item, Mirror(reflecting: item).displayStyle == .class, let object = item as? AnyObject {
            observable = map { [weak object] in (object as? T, $0) }
        } else {
            observable = map { (item, $0) }
        }
        
        return observable.map { item, value in
            guard let item = item else { throw RxRuntimeError.itemMissing }
            return (item, value)
        }
    }
}
