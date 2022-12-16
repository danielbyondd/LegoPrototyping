//
//  StorePage.swift
//  
//
//  Created by Daniel Byon on 11/28/22.
//

import Lego
import LegoConsumer
import StoreDomainInterface
import SwiftUI

public struct StorePage: View {

    private let page: LegoPage

    public var body: some View {
        if let group = page.lego.groups.first(where: { $0.name == "group_store_content" }) {
            ScrollView(.vertical) {
                ForEach(group.sections) { group in
                    ForEach(group.content) { lego in
                        LegoView(lego: lego)
                    }
                }
            }
        } else {
            Text("Failed to load store")
        }
    }

    public init(page: LegoPage) {
        self.page = page
    }

}

struct StorePage_Previews: PreviewProvider {
    static let page: LegoPage = {
        LegoBlockContentRegistry.shared.register(Carousel.self, forIdentifier: .carousel)
        LegoBlockContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .carouselHeader)
        LegoBlockContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .defaultCarouselHeader)
        LegoBlockContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .menuCarouselHeader)
        LegoBlockContentRegistry.shared.register(Carousel.self, forIdentifier: .storeCarousel)
        LegoBlockContentRegistry.shared.register(StoreCarouselRectangularItem.self, forIdentifier: .storeCarouselRectangularItem)
        LegoBlockContentRegistry.shared.register(StoreCarouselSquareItem.self, forIdentifier: .storeCarouselSquareItem)
        LegoBlockContentRegistry.shared.register(StoreCarouselSquareItem.self, forIdentifier: .storeMenuCategoryItem)
        LegoBlockContentRegistry.shared.register(StoreFooter.self, forIdentifier: .storeFooter)
        LegoBlockContentRegistry.shared.register(StoreMenuCategory.self, forIdentifier: .storeMenuCategory)
        LegoBlockContentRegistry.shared.register(StoreMenuHeader.self, forIdentifier: .storeMenuHeader)
        LegoBlockContentRegistry.shared.register(StoreRatingsCarousel.self, forIdentifier: .storeRatingsCarousel)

        LegoActionRegistry.shared.register(ItemModalAction.self)

        let data = try! Fixture.loadJSONData(named: "contract-sample-1")
        let decoder = JSONDecoder()
        let responsePage = try! decoder.decode(ResponsePage.self, from: data)
        let page = try! LegoPage(responsePage: responsePage)

        return page
    }()

    static var previews: some View {
        StorePage(page: page)
    }
}
