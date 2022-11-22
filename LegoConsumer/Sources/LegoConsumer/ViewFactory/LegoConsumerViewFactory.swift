//
//  LegoConsumerViewFactory.swift
//  
//
//  Created by Daniel Byon on 11/21/22.
//

import Lego
import LegoPrism
import SwiftUI

public struct LegoConsumerViewFactory: LegoViewFactory {

    public let lego: Lego
    public let nextFactory: any LegoViewFactory

    public var body: some View {
        switch lego.content {
        case let content as Carousel:
            EmptyView()
        default:
            EmptyView()
        }
    }

    public init(
        lego: Lego,
        nextFactory: some LegoViewFactory
    ) {
        self.lego = lego
        self.nextFactory = nextFactory
    }

}
