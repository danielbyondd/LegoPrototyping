//
//  ResponsePage.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public struct ResponsePage: Decodable {

    public struct Lego: Decodable {
        public let groups: [ResponseGroup]
        public let data: [ResponseLegoBlock]
        public let logging: LegoLoggingInfo
    }

    public let lego: Lego

}
