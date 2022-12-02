//
//  LegoIdentifier.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public struct LegoIdentifier {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}

extension LegoIdentifier: Hashable { }
