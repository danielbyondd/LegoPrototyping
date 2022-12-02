//
//  AnyEquatable.swift
//  
//
//  Created by Daniel Byon on 12/2/22.
//

import Foundation

public protocol AnyEquatable {

    func isEqual(to rhs: Any) -> Bool

}

extension AnyEquatable where Self: Equatable {

    public func isEqual(to rhs: Any) -> Bool {
        guard let other = rhs as? Self else {
            return false
        }
        return self == other
    }

}

extension Array: AnyEquatable where Element == AnyEquatable {

    public func isEqual(to rhs: Any) -> Bool {
        guard let other = rhs as? [Element] else {
            return false
        }
        return zip(self, other)
            .allSatisfy(isEqual)
    }

}
