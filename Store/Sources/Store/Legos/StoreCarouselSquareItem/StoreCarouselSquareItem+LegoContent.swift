//
//  StoreCarouselSquareItemResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

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

        public struct QuickAddContext: Codable {
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
