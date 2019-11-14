//
//  Maybe+CatchError.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension PrimitiveSequence where Trait == MaybeTrait {
    public func catchError(when condition: @escaping (Error) throws -> Bool, _ handler: @escaping (Error) throws -> PrimitiveSequence<Trait, Element>) -> PrimitiveSequence<Trait, Element> {
        return catchError { try condition($0) ? try handler($0) : PrimitiveSequence<Trait, Element>.error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenEqual value: T, _ handler: @escaping (Error) throws -> PrimitiveSequence<Trait, Element>) -> PrimitiveSequence<Trait, Element> {
        return catchError { ($0 as? T) == value ? try handler($0) : PrimitiveSequence<Trait, Element>.error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenNotEqual value: T, _ handler: @escaping (Error) throws -> PrimitiveSequence<Trait, Element>) -> PrimitiveSequence<Trait, Element> {
        return catchError { ($0 as? T) != value ? try handler($0) : PrimitiveSequence<Trait, Element>.error($0) }
    }
}
