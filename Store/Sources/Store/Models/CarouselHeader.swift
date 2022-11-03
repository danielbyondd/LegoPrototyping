//
//  CarouselHeader.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

public struct CarouselHeader: LegoContent {

    public let title: PrismText
    public let subtitle: PrismText?

    public enum CodingKeys: String, CodingKey {
        case title
        case subtitle
    }

}

extension LegoContentIdentifier {

    public static let carouselHeader = LegoContentIdentifier(name: "cx.carousel_header")

}
