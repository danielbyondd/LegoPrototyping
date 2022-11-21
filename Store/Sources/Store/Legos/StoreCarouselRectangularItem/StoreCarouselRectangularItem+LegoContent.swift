//
//  StoreCarouselRectangularItemResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

extension StoreCarouselRectangularItem {

    public struct ResponseContent: LegoResponseContent {

        public let id: String
        public let name: String
        public let description: String
        public let displayPrice: String
        public let image: Image
        public let calloutDisplayString: String
        public let nextCursor: Cursor?
        public let quickAddContext: QuickAddContext
        public let storeID: String
        @CodableLegoActions public var actions: [any LegoAction]

        public struct Cursor: Codable {
            public let cursor: String
        }

        public struct QuickAddContext: Codable {
            public let isEligible: Bool
            public let price: Price
            public let specialInstructions: String
            public let options: [Option]

            public struct Price: Codable {
                public let unitAmount: Int
                public let currency: String
                public let displayString: String
                public let decimalPlaces: Int
                public let sign: Bool
                public let symbol: String

                private enum CodingKeys: String, CodingKey {
                    case unitAmount = "unit_amount"
                    case currency
                    case displayString = "display_string"
                    case decimalPlaces = "decimal_places"
                    case sign
                    case symbol
                }
            }

            public struct Option: Codable {
                public let id: String
                public let quantity: Int
                public let name: String
            }

            private enum CodingKeys: String, CodingKey {
                case isEligible = "is_eligible"
                case price
                case specialInstructions = "special_instructions"
                case options
            }
        }

        public enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case displayPrice = "display_price"
            case image
            case calloutDisplayString = "callout_display_string"
            case nextCursor = "next_cursor"
            case quickAddContext = "quick_add_context"
            case storeID = "store_id"
            case actions
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        id = responseContent.id
        name = responseContent.name
        description = responseContent.description
        displayPrice = responseContent.displayPrice
        image = responseContent.image
        calloutDisplayString = responseContent.calloutDisplayString
        if let nextCursor = responseContent.nextCursor {
            self.nextCursor = .init(cursor: nextCursor)
        } else {
            nextCursor = nil
        }
        quickAddContext = .init(quickAddContext: responseContent.quickAddContext)
        storeID = responseContent.storeID
        actions = responseContent.actions
    }

}
