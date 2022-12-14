//
//  ResponseLegoBlock.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public struct ResponseLegoBlock: Decodable {

    public let id: String
    public let type: String
    public let content: any LegoResponseContent
    public let logging: LegoLoggingInfo?

    private enum CodingKeys: String, CodingKey {
        case id = "lego_id"
        case type = "lego_type"
        case content
        case logging
    }

    private enum TypeCodingKeys: String, CodingKey {
        case type = "lego_type"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let type = try container.decode(String.self, forKey: .type)
        self.type = type

        let identifier = LegoBlockIdentifier(name: type)
        let legoType = try LegoBlockContentRegistry.shared.responseContentType(forIdentifier: identifier)
        let lego = try container.decode(legoType, forKey: .content)
        self.content = lego

        self.logging = try container.decodeIfPresent(LegoLoggingInfo.self, forKey: .logging)
    }

}
