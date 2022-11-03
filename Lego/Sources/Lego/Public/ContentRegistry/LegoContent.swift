//
//  LegoContent.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public protocol LegoContent<CodingKeys>: Codable {

    associatedtype CodingKeys: CodingKey

}
