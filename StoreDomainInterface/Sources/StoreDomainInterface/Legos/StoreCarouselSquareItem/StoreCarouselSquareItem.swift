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

    public struct QuickAddContext {
        public let isEligible: Bool

        init(quickAddContext: ResponseContent.QuickAddContext) {
            isEligible = quickAddContext.isEligible
        }
    }

}

extension LegoIdentifier {

    public static let storeCarouselSquareItem = LegoIdentifier(name: "cx.ox.store.carousel_square_item")

    public static let storeMenuCategoryItem = LegoIdentifier(name: "cx.ox.store.menu_category_item")

}
