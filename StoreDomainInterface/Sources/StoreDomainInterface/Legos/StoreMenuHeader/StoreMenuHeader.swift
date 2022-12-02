//
//  StoreMenuHeader.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct StoreMenuHeader: LegoContent {

    public let name: String
    public let menus: [Menu]
    public let content: [MenuItem]
    public let displayOpenHours: String
    public let currentMenuID: String
    public let shouldHideMenuBookHeader: Bool

    public struct Menu: Hashable {
        public let id: String
        public let name: String
        public let openHours: [Hours]
        public let displayOpenHours: String

        public struct Hours: Hashable {
            public let openTime: String
            public let closeTime: String

            init(hours: ResponseContent.Menu.Hours) {
                openTime = hours.openTime
                closeTime = hours.closeTime
            }
        }

        init(menu: ResponseContent.Menu) {
            id = menu.id
            name = menu.name
            openHours = menu.openHours.map(Hours.init)
            displayOpenHours = menu.displayOpenHours
        }
    }

    public struct MenuItem: Hashable {
        public let id: String
        public let name: String
        public let numberOfItems: Int
        public let next: Next

        public struct Next: Hashable {
            public let anchor: String

            init(next: ResponseContent.MenuItem.Next) {
                anchor = next.anchor
            }
        }

        init(menuItem: ResponseContent.MenuItem) {
            id = menuItem.id
            name = menuItem.name
            numberOfItems = menuItem.numberOfItems
            next = .init(next: menuItem.next)
        }
    }

}

extension LegoIdentifier {

    public static let storeMenuHeader = LegoIdentifier(name: "cx.ox.store.menu_header")

}

extension StoreMenuHeader {

    public struct ResponseContent: LegoResponseContent {

        public let name: String
        public let menus: [Menu]
        public let content: [MenuItem]
        public let displayOpenHours: String
        public let currentMenuID: String
        public let shouldHideMenuBookHeader: Bool

        public struct Menu: Codable, Hashable {
            public let id: String
            public let name: String
            public let openHours: [Hours]
            public let displayOpenHours: String

            public struct Hours: Codable, Hashable {
                public let openTime: String
                public let closeTime: String

                private enum CodingKeys: String, CodingKey {
                    case openTime = "open_time"
                    case closeTime = "close_time"
                }
            }

            private enum CodingKeys: String, CodingKey {
                case id
                case name
                case openHours = "open_hours"
                case displayOpenHours = "display_open_hours"
            }
        }

        public struct MenuItem: Codable, Hashable {
            public let id: String
            public let name: String
            public let numberOfItems: Int
            public let next: Next

            public struct Next: Codable, Hashable {
                public let anchor: String
            }

            private enum CodingKeys: String, CodingKey {
                case id
                case name
                case numberOfItems = "numItems"
                case next
            }
        }

        public enum CodingKeys: String, CodingKey {
            case name
            case menus
            case content
            case displayOpenHours = "display_open_hours"
            case currentMenuID = "current_menu_id"
            case shouldHideMenuBookHeader = "should_hide_menu_book_header"
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        name = responseContent.name
        menus = responseContent.menus.map(Menu.init)
        content = responseContent.content.map(MenuItem.init)
        displayOpenHours = responseContent.displayOpenHours
        currentMenuID = responseContent.currentMenuID
        shouldHideMenuBookHeader = responseContent.shouldHideMenuBookHeader
    }

}
