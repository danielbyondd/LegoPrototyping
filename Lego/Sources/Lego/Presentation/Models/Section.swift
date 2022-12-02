//
//  Section.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct Section: Identifiable {

    public let id: String
    public let content: [Lego]

    init(
        responseSection: ResponseSection,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        id = responseSection.id
        content = try legoFactory.makeLegoArray(forIDs: responseSection.content, parentLoggingInfo: parentLoggingInfo)
    }

}
