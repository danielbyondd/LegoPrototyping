//
//  ItemModalAction.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation
import Lego

public struct ItemModalAction: LegoAction {

    public struct Content: LegoActionContent {

        public let itemID: String
        public let uri: URL

        public enum CodingKeys: String, CodingKey {
            case itemID = "item_id"
            case uri
        }

    }

    public struct UserInterfaceData {

        public init() { }

    }

    public static let identifier = LegoActionIdentifier(name: "item.modal")

    public let content: Content

    public init(content: Content) {
        self.content = content
    }

    public func execute(userInterfaceData: UserInterfaceData) async throws {
        
    }

}
