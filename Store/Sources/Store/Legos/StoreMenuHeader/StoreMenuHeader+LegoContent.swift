//
//  StoreMenuHeaderResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

extension StoreMenuHeader {

    public struct ResponseContent: LegoResponseContent {

        public let name: String
        public let menus: [Menu]
        public let content: [MenuItem]
        public let displayOpenHours: String
        public let currentMenuID: String
        public let shouldHideMenuBookHeader: Bool

        public struct Menu: Codable {
            public let id: String
            public let name: String
            public let openHours: [Hours]
            public let displayOpenHours: String

            public struct Hours: Codable {
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

        public struct MenuItem: Codable {
            public let id: String
            public let name: String
            public let numberOfItems: Int
            public let next: Next

            public struct Next: Codable {
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
