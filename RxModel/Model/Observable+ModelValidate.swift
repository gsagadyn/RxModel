//
//  Observable+ModelValidate.swift
//  RxModel
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension Observable where Element: IModelValidation {
    
    /// Validates model.
    ///
    /// - returns: The observable sequence with validated object.
    public func validate() -> Observable<Element> {
        return self.flatMap { obj -> Observable<Element> in
            if let error = obj.validate() {
                return Observable<Element>.error(error)
            } else {
                return Observable<Element>.just(obj)
            }
        }
    }
    
}
