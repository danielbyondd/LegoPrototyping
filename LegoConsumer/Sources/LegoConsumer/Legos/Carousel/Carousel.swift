//
//  Carousel.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego

public struct Carousel: LegoContent {

    public let header: Lego
    public let children: [Lego]

}

extension LegoIdentifier {

    public static let carousel = LegoIdentifier(name: "cx.carousel")

}
