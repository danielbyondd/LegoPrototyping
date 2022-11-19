//
//  StoreFooterResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

extension StoreFooter {

    public struct ResponseContent: LegoResponseContent {

        public var empty: String? = nil

        public enum CodingKeys: String, CodingKey {
            case empty
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {

    }

}
