//
//  Observable+ModelValidate.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension Observable where E: IModelValidation {
    
    /// Validates model.
    ///
    /// - returns: The observable sequence with validated object.
    public func validate() -> Observable<E> {
        return self.flatMap { obj -> Observable<E> in
            if let error = obj.validate() {
                return Observable<E>.error(error)
            } else {
                return Observable<E>.just(obj)
            }
        }
    }
    
}
