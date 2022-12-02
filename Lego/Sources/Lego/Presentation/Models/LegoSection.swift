//
//  Section.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct Section: Identifiable, Hashable {

    public let id: String
    public let content: [LegoBlock]

    init(
        responseSection: ResponseSection,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        id = responseSection.id
        content = try legoFactory.makeLegoArray(forIDs: responseSection.content, parentLoggingInfo: parentLoggingInfo)
    }

}
