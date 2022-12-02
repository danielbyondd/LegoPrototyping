//
//  CarouselHeader.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation
import Lego
import LegoPrism

public struct CarouselHeader {

    public let title: PrismText
    public let subtitle: PrismText?

}

extension LegoIdentifier {

    public static let carouselHeader = LegoIdentifier(name: "cx.carousel_header")

    public static let defaultCarouselHeader = LegoIdentifier(name: "cx.carousel_header_default")

}
