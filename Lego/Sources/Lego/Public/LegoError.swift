//
//  LegoError.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

public enum LegoError: Error {
    case legoContentTypeMismatch(expected: Any, actual: Any)
}
