//
//  StoreFooter.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

public struct StoreFooter: LegoContent {

    public var empty: String? = nil

    public enum CodingKeys: String, CodingKey {
        case empty
    }

}

extension LegoContentIdentifier {

    public static let storeFooter = LegoContentIdentifier(name: "cx.ox.store.footer")

}
