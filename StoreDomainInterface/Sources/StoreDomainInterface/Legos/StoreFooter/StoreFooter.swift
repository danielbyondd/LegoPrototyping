//
//  StoreFooter.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct StoreFooter: LegoBlockContent {

}

extension LegoBlockIdentifier {

    public static let storeFooter = LegoBlockIdentifier(name: "cx.ox.store.footer")

}

extension StoreFooter {

    public struct ResponseContent: LegoResponseContent {

        public var empty: String? = nil

        public enum CodingKeys: String, CodingKey {
            case empty
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {

    }

}
