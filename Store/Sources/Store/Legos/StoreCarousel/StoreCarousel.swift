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

extension LegoContentIdentifier {

    public static let storeCarousel = LegoContentIdentifier(name: "cx.ox.store.carousel")

}
