//
//  LegoLoggingInfo.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public struct LegoLoggingInfo: Codable {

    public let attributes: [Attribute]

    public struct Attribute: Codable {
        public let key: String
        public let value: String
        public let shouldPassDown: Bool

        private enum CodingKeys: String, CodingKey {
            case key
            case value
            case shouldPassDown = "pass_down"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.key = try container.decode(String.self, forKey: .key)
            self.value = try container.decode(String.self, forKey: .value)
            self.shouldPassDown = try container.decodeIfPresent(Bool.self, forKey: .shouldPassDown) ?? false
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(key, forKey: .key)
            try container.encode(value, forKey: .value)
            try container.encode(shouldPassDown, forKey: .shouldPassDown)
        }
    }

}
