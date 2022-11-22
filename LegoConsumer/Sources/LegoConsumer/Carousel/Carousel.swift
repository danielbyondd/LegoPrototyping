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

extension LegoContentIdentifier {

    public static let carousel = LegoContentIdentifier(name: "cx.carousel")

}
