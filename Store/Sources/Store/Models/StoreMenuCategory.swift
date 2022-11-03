//
//  StoreMenuCategory.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

public struct StoreMenuCategory: LegoContent {

    public let headerID: String
    public let children: [String]

    public enum CodingKeys: String, CodingKey {
        case headerID = "header_id"
        case children
    }

}

extension LegoContentIdentifier {

    public static let storeMenuCategory = LegoContentIdentifier(name: "cx.ox.store.menu_category")

}
