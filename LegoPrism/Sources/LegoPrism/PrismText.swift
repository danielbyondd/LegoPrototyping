//
//  PrismText.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public struct PrismText: Codable, Hashable {

    public let text: String
    public let style: String
    public let color: String

    private enum CodingKeys: String, CodingKey {
        case text
        case style = "prism_style"
        case color = "prism_color"
    }

}
