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
        // TODO: Manually implement decoding, drop unrecognized blocks, for backwards compatibility
        public let data: [ResponseLegoBlock]
        public let logging: LegoLoggingInfo
    }

    private enum CodingKeys: String, CodingKey {
        case lego
    }

    public let lego: Lego

}
