//
//  StoreCarouselResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

extension StoreCarousel {

    public struct ResponseContent: LegoResponseContent {

        public let headerID: String
        public let children: [String]

        public enum CodingKeys: String, CodingKey {
            case headerID = "header_id"
            case children
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        header = try legoFactory.makeLego(forID: responseContent.headerID, parentLoggingInfo: parentLoggingInfo)
        children = try legoFactory.makeLegoArray(forIDs: responseContent.children, parentLoggingInfo: parentLoggingInfo)
    }

}
