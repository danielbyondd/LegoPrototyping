//
//  Page.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct Page {

    public struct Lego {
        public let groups: [Group]
        public let logging: LegoLoggingInfo

        init(lego: ResponsePage.Lego) throws {
            let legoFactory = LegoFactory(responseLegos: lego.data)
            groups = try lego.groups.map { try .init(responseGroup: $0, legoFactory: legoFactory, parentLoggingInfo: lego.logging) }
            logging = lego.logging
        }
    }

    public let lego: Lego

    init(responsePage: ResponsePage) throws {
        lego = try .init(lego: responsePage.lego)
    }

}
