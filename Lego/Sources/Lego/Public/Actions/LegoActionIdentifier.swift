//
//  LegoActionIdentifier.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public struct LegoActionIdentifier {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

extension LegoActionIdentifier: Hashable { }
