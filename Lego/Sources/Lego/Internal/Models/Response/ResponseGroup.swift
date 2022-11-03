//
//  ResponseGroup.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

struct ResponseGroup: Decodable {

    let name: String
    let sections: [ResponseSection]
    let logging: LegoLoggingInfo

    private enum CodingKeys: String, CodingKey {
        case name = "group_name"
        case sections
        case logging
    }

}
