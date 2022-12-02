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

extension LegoBlockIdentifier {

    public static let carouselHeader = LegoBlockIdentifier(name: "cx.carousel_header")

    public static let defaultCarouselHeader = LegoBlockIdentifier(name: "cx.carousel_header_default")

}

extension CarouselHeader: LegoBlockContent {

    public struct ResponseContent: LegoResponseContent {

        public let title: PrismText
        public let subtitle: PrismText?

        public enum CodingKeys: String, CodingKey {
            case title
            case subtitle
        }

    }

    public init(
        responseContent: ResponseContent,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        self.title = responseContent.title
        self.subtitle = responseContent.subtitle
    }

}
