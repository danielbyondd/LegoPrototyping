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

    public struct Menu {
        public let id: String
        public let name: String
        public let openHours: [Hours]
        public let displayOpenHours: String

        public struct Hours {
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

    public struct MenuItem {
        public let id: String
        public let name: String
        public let numberOfItems: Int
        public let next: Next

        public struct Next {
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
