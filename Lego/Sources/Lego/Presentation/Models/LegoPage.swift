//
//  LegoPage.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct LegoPage: Hashable {

    public struct Lego: Hashable {
        public let groups: [LegoGroup]
        public let logging: LegoLoggingInfo

        init(lego: ResponsePage.Lego) throws {
            let legoFactory = LegoBlockFactory(responseLegos: lego.data)
            groups = try lego.groups.map { try .init(responseGroup: $0, legoFactory: legoFactory, parentLoggingInfo: lego.logging) }
            logging = lego.logging
        }
    }

    public let lego: Lego

    public init(responsePage: ResponsePage) throws {
        lego = try .init(lego: responsePage.lego)
    }

}
