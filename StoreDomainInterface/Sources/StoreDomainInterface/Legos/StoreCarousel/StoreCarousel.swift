//
//  StoreCarousel.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct StoreCarousel: LegoContent {

    public let header: Lego
    public let children: [Lego]

}

extension LegoIdentifier {

    public static let storeCarousel = LegoIdentifier(name: "cx.ox.store.carousel")

}

extension StoreCarousel: LegoViewFactoryDescriptionConvertible {

    public func toViewFactoryDescription() -> LegoViewFactoryDescription {
        StoreViewFactoryDescription.carousel(self)
    }

}
