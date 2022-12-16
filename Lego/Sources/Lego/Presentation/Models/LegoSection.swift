//
//  LegoSection.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct LegoSection: Identifiable, Hashable {

    public let id: String
    public var content: [LegoBlock]

    init(
        responseSection: ResponseSection,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        id = responseSection.id
        content = try legoFactory.makeLegoArray(forIDs: responseSection.content, parentLoggingInfo: parentLoggingInfo)
    }

    public func findLegoContent<T: LegoBlockContent>(_: T.Type) -> [T] {
        return content.compactMap { $0.content as? T }
    }

}
