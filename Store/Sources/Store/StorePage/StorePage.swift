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

    private let page: Page

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

    public init(page: Page) {
        self.page = page
    }

}

struct StorePage_Previews: PreviewProvider {
    static let page: Page = {
        LegoContentRegistry.shared.register(Carousel.self, forIdentifier: .carousel)
        LegoContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .carouselHeader)
        LegoContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .defaultCarouselHeader)
        LegoContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .menuCarouselHeader)
        LegoContentRegistry.shared.register(Carousel.self, forIdentifier: .storeCarousel)
        LegoContentRegistry.shared.register(StoreCarouselRectangularItem.self, forIdentifier: .storeCarouselRectangularItem)
        LegoContentRegistry.shared.register(StoreCarouselSquareItem.self, forIdentifier: .storeCarouselSquareItem)
        LegoContentRegistry.shared.register(StoreCarouselSquareItem.self, forIdentifier: .storeMenuCategoryItem)
        LegoContentRegistry.shared.register(StoreFooter.self, forIdentifier: .storeFooter)
        LegoContentRegistry.shared.register(StoreMenuCategory.self, forIdentifier: .storeMenuCategory)
        LegoContentRegistry.shared.register(StoreMenuHeader.self, forIdentifier: .storeMenuHeader)
        LegoContentRegistry.shared.register(StoreRatingsCarousel.self, forIdentifier: .storeRatingsCarousel)

        LegoActionRegistry.shared.register(ItemModalAction.self)

        let data = try! Fixture.loadJSONData(named: "contract-sample-1")
        let decoder = JSONDecoder()
        let responsePage = try! decoder.decode(ResponsePage.self, from: data)
        let page = try! Page(responsePage: responsePage)

        return page
    }()

    static var previews: some View {
        StorePage(page: page)
    }
}
