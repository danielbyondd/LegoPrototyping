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

extension CarouselHeader: LegoContent {

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
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        self.title = responseContent.title
        self.subtitle = responseContent.subtitle
    }

}
