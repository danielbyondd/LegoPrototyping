//
//  ResponsePage.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

struct ResponsePage: Decodable {

    let groups: [ResponseGroup]
    let data: [ResponseLego]
    let logging: LegoLoggingInfo

}
