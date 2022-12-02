//
//  LegoFactory.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

public final class LegoFactory {

    private let lookupDict: [String: ResponseLego]

    public init(responseLegos: [ResponseLego]) {
        self.lookupDict = responseLegos.reduce(into: [:]) { lookupDict, lego in
            lookupDict[lego.id] = lego
        }
    }

    public func makeLego(forID legoID: String, parentLoggingInfo: LegoLoggingInfo?) throws -> Lego {
        guard let responseLego = lookupDict[legoID] else {
            throw LegoFactoryError.identifierNotFound(legoID)
        }
        let lego = try Lego(
            responseLego: responseLego,
            legoFactory: self,
            parentLoggingInfo: parentLoggingInfo
        )
        return lego
    }

    public func makeLego(for responseLego: ResponseLego, parentLoggingInfo: LegoLoggingInfo?) throws -> Lego {
        let id = responseLego.id
        return try makeLego(forID: id, parentLoggingInfo: parentLoggingInfo)
    }

    public func makeLegoArray(forIDs legoIDs: [String], parentLoggingInfo: LegoLoggingInfo?) throws -> [Lego] {
        return try legoIDs.map { try makeLego(forID: $0, parentLoggingInfo: parentLoggingInfo) }
    }

}
