//
//  Group.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct Group: Hashable {

    public let name: String
    public let sections: [Section]
    public let logging: LegoLoggingInfo

    init(
        responseGroup: ResponseGroup,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        name = responseGroup.name

        let logging = responseGroup.logging.combine(with: parentLoggingInfo)
        sections = try responseGroup.sections.map { try .init(responseSection: $0, legoFactory: legoFactory, parentLoggingInfo: logging) }

        self.logging = logging
    }
    
}
