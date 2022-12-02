//
//  LegoResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public protocol LegoResponseContent<CodingKeys>: Codable, Hashable {

    associatedtype CodingKeys: CodingKey

}
