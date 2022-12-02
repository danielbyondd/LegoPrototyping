//
//  LegoViewFactoryDescription.swift
//  
//
//  Created by Daniel Byon on 11/28/22.
//

import Foundation

public protocol LegoViewFactoryDescription {

    static var identifier: String { get }

}

extension LegoViewFactoryDescription {

    public var identifier: String { Self.identifier }

}
