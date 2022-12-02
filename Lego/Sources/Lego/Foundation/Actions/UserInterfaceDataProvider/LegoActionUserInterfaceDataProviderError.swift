//
//  LegoActionUserInterfaceDataProviderError.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

public enum LegoActionUserInterfaceDataProviderError: Error {
    case unexpectedActionType(any LegoAction)
    case unexpectedUserInterfaceDataType(Any)
    case unregisteredIdentifier(LegoActionIdentifier)
}
