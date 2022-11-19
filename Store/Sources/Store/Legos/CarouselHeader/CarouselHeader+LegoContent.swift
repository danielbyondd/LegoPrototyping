//
//  CarouselHeaderResponseContent.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
import Lego

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
