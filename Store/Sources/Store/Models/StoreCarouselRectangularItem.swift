//
//  StoreCarouselRectangularItem.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
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
    public let quickAddContext: QuickAddContext
    public let ratingDisplayString: String
    @CodableLegoActions public var actions: [any LegoAction]
    public let logging: LegoLoggingInfo

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
        case calloutDisplayString = "callout_display_string"
        case quickAddContext = "quick_add_context"
        case ratingDisplayString = "rating_display_string"
        case actions
        case logging
    }

}

extension LegoContentIdentifier {

    public static let storeCarouselRectangularItem = LegoContentIdentifier(name: "cx.ox.store.carousel_rectangular_item")

}
