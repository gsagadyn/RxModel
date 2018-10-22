//
//  Expiry.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 17/10/2018.
//

import Foundation

public enum Expiry {
    /// Object will be expired in the nearest future
    case never
    
    /// Object will be expired in the specified amount of seconds
    case seconds(TimeInterval)
    
    /// Object will be expired on the specified date
    case date(Date)
}

// -----------------------------------------------------------------------------
// MARK: - Helpers
// -----------------------------------------------------------------------------

internal extension Expiry {
    private static let futureDate = Date(timeIntervalSince1970: TimeInterval.greatestFiniteMagnitude)
    
    internal var date: Date {
        switch self {
        case .never:
            return Expiry.futureDate
        case .seconds(let seconds):
            return Date().addingTimeInterval(seconds)
        case .date(let date):
            return date
        }
    }
}
