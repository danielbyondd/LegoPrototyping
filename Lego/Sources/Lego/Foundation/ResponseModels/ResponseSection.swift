//
//  ResponseSection.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public struct ResponseSection: Decodable {

    public let id: String
    public let content: [String]

    private enum CodingKeys: String, CodingKey {
        case id = "section_id"
        case content
    }

}
