//
//  LegoView.swift
//  
//
//  Created by Daniel Byon on 11/21/22.
//

import SwiftUI

public struct LegoView: View {

    public let lego: Lego

    // TODO: Resolve this as a service
    private let registry: LegoViewRegistry = .shared

    public var body: some View {
        // TODO: I hate this, look for a way to not use AnyView in Q1
        AnyView(registry.makeLegoContentView(for: lego))
    }

    public init(lego: Lego) {
        self.lego = lego
    }

}

//public protocol LegoView<Content>: View {
//
//    associatedtype Content: View
//
//    @ViewBuilder
//    var viewFactory: (LegoViewFactoryDescription) -> Content { get }
//
//}

//public struct LegoView<Content: View>: View {
//
//    private let description: LegoViewFactoryDescription
//    @ViewBuilder
//    private let factory: (LegoViewFactoryDescription) -> Content
//
//    public var body: some View {
//        factory(description)
//    }
//
//    init(
//        description: LegoViewFactoryDescription,
//        @ViewBuilder factory: @escaping (LegoViewFactoryDescription) -> Content
//    ) {
//        self.description = description
//        self.factory = factory
//    }
//
//}





public protocol LegoContentView<Content>: View {

    associatedtype Content: LegoContent

    init(content: Content)

}

extension LegoContentView {

    public init(anyContent: any LegoContent) throws {
        guard let content = anyContent as? Content else {
            throw LegoContentViewError.contentTypeMismatch(expected: Content.self, actual: Swift.type(of: anyContent))
        }
        self.init(content: content)
    }

}

public enum LegoContentViewError: Error {
    case contentTypeMismatch(expected: Any, actual: Any)
}
