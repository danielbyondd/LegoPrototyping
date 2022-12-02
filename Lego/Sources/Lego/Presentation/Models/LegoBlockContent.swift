//
//  LegoBlockContent.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

public protocol LegoBlockContent<ResponseContent>: AnyEquatable, Hashable {

    associatedtype ResponseContent: LegoResponseContent

    init(
        responseContent: ResponseContent,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws

}
