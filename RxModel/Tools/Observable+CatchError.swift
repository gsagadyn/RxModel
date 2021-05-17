//
//  Observable+CatchError.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension Observable {
    public func catchError(when condition: @escaping (Error) throws -> Bool, _ handler: @escaping (Error) throws -> Observable<Element>) -> Observable<Element> {
        return self.catch { try condition($0) ? try handler($0) : .error($0) }
    }
    
    public func catchError(when condition: @escaping (Error) throws -> Bool, justReturnValue result: Element) -> Observable<Element> {
        return self.catch { try condition($0) ? .just(result) : .error($0) }
    }
    
    public func catchError(when condition: @escaping (Error) throws -> Bool, justReturnError error: Error) -> Observable<Element> {
        return self.catch { try condition($0) ? .error(error) : .error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenEqual value: T, _ handler: @escaping (Error) throws -> Observable<Element>) -> Observable<Element> {
        return self.catch { ($0 as? T) == value ? try handler($0) : .error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenEqual value: T, justReturnValue result: Element) -> Observable<Element> {
        return self.catch { ($0 as? T) == value ? .just(result) : .error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenEqual value: T, justReturnError error: Error) -> Observable<Element> {
        return self.catch { ($0 as? T) == value ? .error(error) : .error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenNotEqual value: T, _ handler: @escaping (Error) throws -> Observable<Element>) -> Observable<Element> {
        return self.catch { ($0 as? T) != value ? try handler($0) : .error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenNotEqual value: T, justReturnValue result: Element) -> Observable<Element> {
        return self.catch { ($0 as? T) != value ? .just(result) : .error($0) }
    }
    
    public func catchError<T: Error & Equatable>(whenNotEqual value: T, justReturnError error: Error) -> Observable<Element> {
        return self.catch { ($0 as? T) != value ? .error(error) : .error($0) }
    }
}
