//
//  StoreViewFactory.swift
//  
//
//  Created by Daniel Byon on 11/21/22.
//

import Lego
import LegoConsumer
import SwiftUI

//public struct StoreViewFactory: LegoViewFactory {
//
//    public let lego: Lego
//    public let rootFactory: any LegoViewFactory
//    public let nextFactory: any LegoViewFactory
//
//    public var body: some View {
//        EmptyView()
//    }
//
//    public func makeLegoView(for lego: Lego) -> some View {
//        EmptyView()
//    }
//
//}

public protocol StoreViewFactory {

    associatedtype Carousel: View

    func makeCarousel(storeCarousel: StoreCarousel) -> Carousel

}
