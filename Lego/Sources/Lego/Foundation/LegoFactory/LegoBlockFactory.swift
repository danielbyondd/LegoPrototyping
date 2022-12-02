//
//  LegoBlockFactory.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

public final class LegoBlockFactory {

    private let lookupDict: [String: ResponseLegoBlock]

    public init(responseLegos: [ResponseLegoBlock]) {
        self.lookupDict = responseLegos.reduce(into: [:]) { lookupDict, lego in
            lookupDict[lego.id] = lego
        }
    }

    public func makeLego(forID legoID: String, parentLoggingInfo: LegoLoggingInfo?) throws -> LegoBlock {
        guard let responseLego = lookupDict[legoID] else {
            throw LegoBlockFactoryError.identifierNotFound(legoID)
        }
        let lego = try LegoBlock(
            responseLego: responseLego,
            legoFactory: self,
            parentLoggingInfo: parentLoggingInfo
        )
        return lego
    }

    public func makeLego(for responseLego: ResponseLegoBlock, parentLoggingInfo: LegoLoggingInfo?) throws -> LegoBlock {
        let id = responseLego.id
        return try makeLego(forID: id, parentLoggingInfo: parentLoggingInfo)
    }

    public func makeLegoArray(forIDs legoIDs: [String], parentLoggingInfo: LegoLoggingInfo?) throws -> [LegoBlock] {
        return try legoIDs.map { try makeLego(forID: $0, parentLoggingInfo: parentLoggingInfo) }
    }

}
