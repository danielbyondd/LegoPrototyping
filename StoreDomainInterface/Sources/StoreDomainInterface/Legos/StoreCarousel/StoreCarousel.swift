//
//  StoreCarousel.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct StoreCarousel: LegoBlockContent {

    public let header: LegoBlock
    public let children: [LegoBlock]

}

extension LegoBlockIdentifier {

    public static let storeCarousel = LegoBlockIdentifier(name: "cx.ox.store.carousel")

}

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
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        header = try legoFactory.makeLego(forID: responseContent.headerID, parentLoggingInfo: parentLoggingInfo)
        children = try legoFactory.makeLegoArray(forIDs: responseContent.children, parentLoggingInfo: parentLoggingInfo)
    }

}
