//
//  StoreCarouselRectangularItem.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct StoreCarouselRectangularItem: LegoContent {

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

    public struct Cursor {
        public let cursor: String

        init(cursor: ResponseContent.Cursor) {
            self.cursor = cursor.cursor
        }
    }

    public struct QuickAddContext {
        public let isEligible: Bool
        public let price: Price
        public let specialInstructions: String
        public let options: [Option]

        public struct Price {
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

        public struct Option {
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

}

extension LegoContentIdentifier {

    public static let storeCarouselRectangularItem = LegoContentIdentifier(name: "cx.ox.store.carousel_rectangular_item")

}
