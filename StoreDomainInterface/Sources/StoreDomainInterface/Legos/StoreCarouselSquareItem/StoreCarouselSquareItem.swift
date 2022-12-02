//
//  StoreCarouselSquareItem.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego
import LegoConsumer

public struct StoreCarouselSquareItem: LegoContent {

    public let id: String
    public let name: String
    public let description: String
    public let displayPrice: String
    public let image: Image
    public let quickAddContext: QuickAddContext
    public let ratingDisplayString: String
    public let storeID: String
    public let actions: [any LegoAction]

    public struct QuickAddContext: Hashable {
        public let isEligible: Bool

        init(quickAddContext: ResponseContent.QuickAddContext) {
            isEligible = quickAddContext.isEligible
        }
    }

    public static func == (lhs: StoreCarouselSquareItem, rhs: StoreCarouselSquareItem) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.description == rhs.description
        && lhs.displayPrice == rhs.displayPrice
        && lhs.image == rhs.image
        && lhs.quickAddContext == rhs.quickAddContext
        && lhs.ratingDisplayString == rhs.ratingDisplayString
        && lhs.storeID == rhs.storeID
        && lhs.actions == rhs.actions
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(displayPrice)
        hasher.combine(image)
        hasher.combine(quickAddContext)
        hasher.combine(ratingDisplayString)
        hasher.combine(storeID)
        hasher.combine(actions.hashValue)
    }

}

extension LegoIdentifier {

    public static let storeCarouselSquareItem = LegoIdentifier(name: "cx.ox.store.carousel_square_item")

    public static let storeMenuCategoryItem = LegoIdentifier(name: "cx.ox.store.menu_category_item")

}

extension StoreCarouselSquareItem {

    public struct ResponseContent: LegoResponseContent {

        public let id: String
        public let name: String
        public let description: String
        public let displayPrice: String
        public let image: Image
        public let quickAddContext: QuickAddContext
        public let ratingDisplayString: String
        public let storeID: String
        @CodableLegoActions public var actions: [any LegoAction]

        public struct QuickAddContext: Codable, Hashable {
            public let isEligible: Bool

            private enum CodingKeys: String, CodingKey {
                case isEligible = "is_eligible"
            }
        }

        public enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case displayPrice = "display_price"
            case image
            case quickAddContext = "quick_add_context"
            case ratingDisplayString = "rating_display_string"
            case storeID = "store_id"
            case actions
        }

        public static func == (lhs: ResponseContent, rhs: ResponseContent) -> Bool {
            return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.description == rhs.description
            && lhs.displayPrice == rhs.displayPrice
            && lhs.image == rhs.image
            && lhs.quickAddContext == rhs.quickAddContext
            && lhs.ratingDisplayString == rhs.ratingDisplayString
            && lhs.storeID == rhs.storeID
            && lhs.actions == rhs.actions
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(description)
            hasher.combine(displayPrice)
            hasher.combine(image)
            hasher.combine(quickAddContext)
            hasher.combine(ratingDisplayString)
            hasher.combine(storeID)
            hasher.combine(actions.hashValue)
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        self.id = responseContent.id
        self.name = responseContent.name
        self.description = responseContent.description
        self.displayPrice = responseContent.displayPrice
        self.image = responseContent.image
        self.quickAddContext = .init(quickAddContext: responseContent.quickAddContext)
        self.ratingDisplayString = responseContent.ratingDisplayString
        self.storeID = responseContent.storeID
        self.actions = responseContent.actions
    }

}
