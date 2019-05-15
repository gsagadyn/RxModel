//
//  Collection+ReduceStop.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

extension Collection {
    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller. A closure allows to break execution of the reduce method
    ///     by setting inout variable to `true`.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element, inout Bool) throws -> Result) rethrows -> Result {
        var stop = false
        var result = initialResult
        
        for element in self {
            result = try nextPartialResult(result, element, &stop)
            guard !stop else { break }
        }
        
        return result
    }
    
    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller. A closure provides also information about an index of an
    ///     element and allows to break execution of the reduce method by setting
    ///     inout variable to `true`.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Int, Element, inout Bool) throws -> Result) rethrows -> Result {
        var stop = false
        var result = initialResult
        
        for (index, element) in enumerated() {
            result = try nextPartialResult(result, index, element, &stop)
            guard !stop else { break }
        }
        
        return result
    }
    
    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence. A closure allows to break
    ///     execution of the reduce method by setting inout variable to `true`.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: (inout Result, Element, inout Bool) throws -> ()) rethrows -> Result {
        var stop = false
        var result = initialResult
        
        for element in self {
            try updateAccumulatingResult(&result, element, &stop)
            guard !stop else { break }
        }
        
        return result
    }
    
    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element and an index of the sequence. A closure allows
    ///     to break execution of the reduce method by setting inout variable
    ///     to `true`.
    /// - Returns: The final accumulated value. If the sequence has no elements,
    ///   the result is `initialResult`.
    public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: (inout Result, Int, Element, inout Bool) throws -> ()) rethrows -> Result {
        var stop = false
        var result = initialResult
        
        for (index, element) in enumerated() {
            try updateAccumulatingResult(&result, index, element, &stop)
            guard !stop else { break }
        }
        
        return result
    }
}
