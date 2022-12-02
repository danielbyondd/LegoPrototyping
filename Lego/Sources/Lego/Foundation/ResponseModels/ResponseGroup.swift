//
//  ResponseGroup.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public struct ResponseGroup: Decodable {

    public let name: String
    public let sections: [ResponseSection]
    public let logging: LegoLoggingInfo

    private enum CodingKeys: String, CodingKey {
        case name = "group_name"
        case sections
        case logging
    }

}
