//
//  LegoBlockContentRegistryError.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public enum LegoBlockContentRegistryError: Error {
    case unregisteredContentIdentifier(LegoBlockIdentifier)
}
