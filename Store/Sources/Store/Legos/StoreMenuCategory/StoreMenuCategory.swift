//
//  StoreMenuCategory.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct StoreMenuCategory: LegoContent {

    public let header: Lego
    public let children: [Lego]

}

extension LegoContentIdentifier {

    public static let storeMenuCategory = LegoContentIdentifier(name: "cx.ox.store.menu_category")

}