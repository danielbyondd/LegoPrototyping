//
//  LegoContent.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

public protocol LegoContent<ResponseContent> {

    associatedtype ResponseContent: LegoResponseContent

    init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws

}
