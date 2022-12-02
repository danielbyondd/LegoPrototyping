//
//  LegoView.swift
//  
//
//  Created by Daniel Byon on 11/21/22.
//

import SwiftUI

public struct LegoView: View {

    public let lego: LegoBlock

    // TODO: Resolve this as a service
    private let registry: LegoViewRegistry = .shared

    public var body: some View {
        // TODO: I hate this, look for a way to not use AnyView in Q1
        AnyView(registry.makeLegoContentView(for: lego))
    }

    public init(lego: LegoBlock) {
        self.lego = lego
    }

}

public protocol LegoContentView<Content>: View {

    associatedtype Content: LegoBlockContent

    init(content: Content)

}

extension LegoContentView {

    public init(anyContent: any LegoBlockContent) throws {
        guard let content = anyContent as? Content else {
            throw LegoContentViewError.contentTypeMismatch(expected: Content.self, actual: Swift.type(of: anyContent))
        }
        self.init(content: content)
    }

}

public enum LegoContentViewError: Error {
    case contentTypeMismatch(expected: Any, actual: Any)
}
