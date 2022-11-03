//
//  ResponseSection.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

struct ResponseSection: Decodable {

    let id: String
    let content: [String]

    private enum CodingKeys: String, CodingKey {
        case id = "section_id"
        case content
    }

}
