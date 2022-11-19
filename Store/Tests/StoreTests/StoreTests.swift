import XCTest
@testable import Lego
@testable import Store

final class StoreTests: XCTestCase {

    override func setUp() async throws {
        // This setup code would go in the individual feature team's module setup, like StoreModule.swift
        LegoContentRegistry.shared.register(Carousel.self, forIdentifier: .carousel)
        LegoContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .carouselHeader)
        LegoContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .defaultCarouselHeader)
        LegoContentRegistry.shared.register(CarouselHeader.self, forIdentifier: .menuCarouselHeader)
        LegoContentRegistry.shared.register(StoreCarousel.self, forIdentifier: .storeCarousel)
        LegoContentRegistry.shared.register(StoreCarouselRectangularItem.self, forIdentifier: .storeCarouselRectangularItem)
        LegoContentRegistry.shared.register(StoreCarouselSquareItem.self, forIdentifier: .storeCarouselSquareItem)
        LegoContentRegistry.shared.register(StoreCarouselSquareItem.self, forIdentifier: .storeMenuCategoryItem)
        LegoContentRegistry.shared.register(StoreFooter.self, forIdentifier: .storeFooter)
        LegoContentRegistry.shared.register(StoreMenuCategory.self, forIdentifier: .storeMenuCategory)
        LegoContentRegistry.shared.register(StoreMenuHeader.self, forIdentifier: .storeMenuHeader)
        LegoContentRegistry.shared.register(StoreRatingsCarousel.self, forIdentifier: .storeRatingsCarousel)

        LegoActionRegistry.shared.register(ItemModalAction.self)
    }

    func testDecode() throws {
        let data = try Fixture.loadJSONData(named: "contract-sample-1")
        let decoder = JSONDecoder()
        
        let responsePage = try decoder.decode(ResponsePage.self, from: data)
        XCTAssertFalse(responsePage.lego.groups.isEmpty)
    }

    func testAction() async throws {
        // Decode the page response
        let data = try Fixture.loadJSONData(named: "contract-sample-1")
        let decoder = JSONDecoder()
        let responsePage = try decoder.decode(ResponsePage.self, from: data)

        // Get the action from the rectangular item
        let lego = responsePage.lego.data.first { $0.content is StoreCarouselRectangularItem.ResponseContent }!
        let action = (lego.content as! StoreCarouselRectangularItem.ResponseContent).actions[0]

        // Register the action provider (this would happen from the store carousel UI code)
        var providerCalled = false
        let actionFactory = LegoActionFactory()
        actionFactory.registerDataProvider(for: ItemModalAction.self) { content in
            providerCalled = true
            // Here we return an empty struct, but since it's an associated type, we can pass
            // anything we want from the UI to the action
            return .init()
        }

        // Execute the action. The factory will call the data provider, which will fetch the UI
        // data and pass it to the action implementation, so it can have full context. The UI
        // layer does not need to explicitly know which action it's triggering at this line.
        try await actionFactory.executeAction(action)

        // Assert our data provider was called, meaning our pipeline is working
        XCTAssertTrue(providerCalled)
    }

    func testBuildPage() throws {
        let data = try Fixture.loadJSONData(named: "contract-sample-1")
        let decoder = JSONDecoder()

        let responsePage = try decoder.decode(ResponsePage.self, from: data)

        let page = try Page(responsePage: responsePage)
        XCTAssertFalse(page.lego.groups.isEmpty)
    }

}
