//
//  Sequence+CompactMap.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

extension Sequence where Iterator.Element: OptionalType {
    
    /// Remove nils form sequence.
    ///
    /// - returns: Sequence.
    public func compactMap() -> [Iterator.Element.Wrapped] {
        var result: [Iterator.Element.Wrapped] = []
        for element in self {
            if let element = element.map({ $0 }) {
                result.append(element)
            }
        }
        return result
    }
    
}
