//
//  Observable+Reduce.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension Observable where Element: Collection {
    /// Returns the observable that combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///     `initialResult` is passed to `nextPartialResult` the first time the
    ///     closure is executed.
    ///   - nextPartialResult: A closure that combines an accumulating value and
    ///     an element of the sequence into a new accumulating value, to be used
    ///     in the next call of the `nextPartialResult` closure or returned to
    ///     the caller.
    /// - Returns: The observable with the final accumulated value. If the sequence
    ///   has no elements, the result is `initialResult`.
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: @escaping (Result, Element.Element) throws -> Result) -> Observable<Result> {
        return map { collection -> Result in try collection.reduce(initialResult, nextPartialResult) }
    }
    
    /// Returns the observable that combining the elements of the sequence using the
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
    /// - Returns: The observable with the final accumulated value. If the sequence
    ///   has no elements, the result is `initialResult`.
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: @escaping (Result, Element.Element, inout Bool) throws -> Result) -> Observable<Result> {
        return map { collection -> Result in try collection.reduce(initialResult, nextPartialResult) }
    }
    
    /// Returns the observable that combining the elements of the sequence using the
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
    /// - Returns: The observable with the final accumulated value. If the sequence
    ///   has no elements, the result is `initialResult`.
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: @escaping (Result, Int, Element.Element, inout Bool) throws -> Result) -> Observable<Result> {
        return map { collection -> Result in try collection.reduce(initialResult, nextPartialResult) }
    }
    
    /// Returns the observable that combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence.
    /// - Returns: The observable with the final accumulated value. If the sequence
    ///   has no elements, the result is `initialResult`.
    public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: @escaping (inout Result, Element.Element) throws -> ()) -> Observable<Result> {
        return map { collection -> Result in try collection.reduce(into: initialResult, updateAccumulatingResult) }
    }
    
    /// Returns the observable that combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element of the sequence. A closure allows to break
    ///     execution of the reduce method by setting inout variable to `true`.
    /// - Returns: The observable with the final accumulated value. If the sequence
    ///   has no elements, the result is `initialResult`.
    public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: @escaping (inout Result, Element.Element, inout Bool) throws -> ()) -> Observable<Result> {
        return map { collection -> Result in try collection.reduce(into: initialResult, updateAccumulatingResult) }
    }
    
    /// Returns the observable that combining the elements of the sequence using the
    /// given closure.
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value.
    ///   - updateAccumulatingResult: A closure that updates the accumulating
    ///     value with an element and an index of the sequence. A closure allows
    ///     to break execution of the reduce method by setting inout variable
    ///     to `true`.
    /// - Returns: The observable with the final accumulated value. If the sequence
    ///   has no elements, the result is `initialResult`.
    public func reduce<Result>(into initialResult: __owned Result, _ updateAccumulatingResult: @escaping (inout Result, Int, Element.Element, inout Bool) throws -> ()) -> Observable<Result> {
        return map { collection -> Result in try collection.reduce(into: initialResult, updateAccumulatingResult) }
    }
}

