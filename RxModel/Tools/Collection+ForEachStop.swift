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
    /// - Parameter body: A closure that takes an element of the sequence as a
    ///   parameter. A closure allows to break execution of the reduce method
    ///   by setting inout variable to `true`.
    public func forEach(_ body: (Element, inout Bool) throws -> Void) rethrows {
        var stop = false
        
        for element in self {
            try body(element, &stop)
            guard !stop else { break }
        }
    }
    
    /// Returns the result of combining the elements of the sequence using the
    /// given closure.
    /// - Parameter body: A closure that takes an element and an index of the
    ///   sequence as a parameter. A closure allows to break execution of the
    ///   reduce method by setting inout variable to `true`.
    public func forEach(_ body: (Int, Element, inout Bool) throws -> Void) rethrows {
        var stop = false
        
        for (index, element) in enumerated() {
            try body(index, element, &stop)
            guard !stop else { break }
        }
    }
}
