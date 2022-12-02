//
//  StoreCarouselRectangularItem.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego
import LegoConsumer

public struct StoreCarouselRectangularItem: LegoBlockContent {

    public let id: String
    public let name: String
    public let description: String
    public let displayPrice: String
    public let image: Image
    public let calloutDisplayString: String
    public let nextCursor: Cursor?
    public let quickAddContext: QuickAddContext
    public let storeID: String
    public let actions: [any LegoAction]

    public struct Cursor: Hashable {
        public let cursor: String

        init(cursor: ResponseContent.Cursor) {
            self.cursor = cursor.cursor
        }
    }

    public struct QuickAddContext: Hashable {
        public let isEligible: Bool
        public let price: Price
        public let specialInstructions: String
        public let options: [Option]

        public struct Price: Hashable {
            public let unitAmount: Int
            public let currency: String
            public let displayString: String
            public let decimalPlaces: Int
            public let sign: Bool
            public let symbol: String

            init(price: ResponseContent.QuickAddContext.Price) {
                unitAmount = price.unitAmount
                currency = price.currency
                displayString = price.displayString
                decimalPlaces = price.decimalPlaces
                sign = price.sign
                symbol = price.symbol
            }
        }

        public struct Option: Hashable {
            public let id: String
            public let quantity: Int
            public let name: String

            init(option: ResponseContent.QuickAddContext.Option) {
                id = option.id
                quantity = option.quantity
                name = option.name
            }
        }

        init(quickAddContext: ResponseContent.QuickAddContext) {
            isEligible = quickAddContext.isEligible
            price = .init(price: quickAddContext.price)
            specialInstructions = quickAddContext.specialInstructions
            options = quickAddContext.options.map(Option.init)
        }
    }

    public static func == (lhs: StoreCarouselRectangularItem, rhs: StoreCarouselRectangularItem) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.description == rhs.description
        && lhs.displayPrice == rhs.displayPrice
        && lhs.image == rhs.image
        && lhs.calloutDisplayString == rhs.calloutDisplayString
        && lhs.nextCursor == rhs.nextCursor
        && lhs.quickAddContext == rhs.quickAddContext
        && lhs.storeID == rhs.storeID
        && lhs.actions == rhs.actions
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(displayPrice)
        hasher.combine(image)
        hasher.combine(calloutDisplayString)
        hasher.combine(nextCursor)
        hasher.combine(quickAddContext)
        hasher.combine(storeID)
        hasher.combine(actions.hashValue)
    }

}

extension LegoBlockIdentifier {

    public static let storeCarouselRectangularItem = LegoBlockIdentifier(name: "cx.ox.store.carousel_rectangular_item")

}

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

        public struct Cursor: Codable, Hashable {
            public let cursor: String
        }

        public struct QuickAddContext: Codable, Hashable {
            public let isEligible: Bool
            public let price: Price
            public let specialInstructions: String
            public let options: [Option]

            public struct Price: Codable, Hashable {
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

            public struct Option: Codable, Hashable {
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

        public static func == (lhs: ResponseContent, rhs: ResponseContent) -> Bool {
            return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.description == rhs.description
            && lhs.displayPrice == rhs.displayPrice
            && lhs.image == rhs.image
            && lhs.calloutDisplayString == rhs.calloutDisplayString
            && lhs.nextCursor == rhs.nextCursor
            && lhs.quickAddContext == rhs.quickAddContext
            && lhs.storeID == rhs.storeID
            && lhs.actions == rhs.actions
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(description)
            hasher.combine(displayPrice)
            hasher.combine(image)
            hasher.combine(calloutDisplayString)
            hasher.combine(nextCursor)
            hasher.combine(quickAddContext)
            hasher.combine(storeID)
            hasher.combine(actions.hashValue)
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoBlockFactory,
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
