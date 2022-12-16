//
//  LegoViewFactory.swift
//  
//
//  Created by Daniel Byon on 11/28/22.
//

import SwiftUI

public final class LegoViewFactory: ObservableObject {

    public static let shared = LegoViewFactory()

    public var next: LegoViewFactory?

    private var registeredContexts: [LegoBlockIdentifier: ViewContext] = [:]

    private struct ViewContext {
        let file: String
        let line: UInt
        let callStack: [String]
        let factory: (Any) throws -> any View
    }

    public init(next: LegoViewFactory? = nil) {
        self.next = next
    }

    public func register<Content, ContentView>(
        _ contentType: Content.Type,
        forIdentifier identifier: LegoBlockIdentifier,
        file: StaticString = #file,
        line: UInt = #line,
        callStack: [String] = Thread.callStackSymbols,
        factory: @escaping (Content) throws -> ContentView
    ) where ContentView: View {
        let context = ViewContext(file: "\(file)", line: line, callStack: callStack) { content in
            guard let content = content as? Content else {
                throw LegoViewRegistryError.contentTypeMismatch(expected: Content.self, actual: Swift.type(of: content))
            }
            return try factory(content)
        }
        registeredContexts[identifier] = context
    }

    public func makeLegoContentView(for identifier: LegoBlockIdentifier, content: Any) -> AnyView {
        guard let context = registeredContexts[identifier] else {
            if let next {
                // If we don't have this identifier registered with this factory, pass it to the next factory in the chain
                return next.makeLegoContentView(for: identifier, content: content)
            } else {
                assertionFailure("No registered content for identifier \(identifier)")
                return AnyView(EmptyView())
            }
        }

        do {
            let contentView = try context.factory(content)
            return AnyView(contentView)
        } catch {
            return AnyView(EmptyView())
        }
    }

    public func makeLegoContentView(for lego: LegoBlock) -> any View {
        makeLegoContentView(for: lego.typeIdentifier, content: lego.content)
//        let identifier = lego.typeIdentifier
//        guard let context = registeredContexts[identifier] else {
//            if let next {
//                // If we don't have this identifier registered with this factory, pass it to the next factory in the chain
//                return next.makeLegoContentView(for: lego)
//            } else {
//                assertionFailure("No registered content for identifier \(identifier)")
//                return EmptyView()
//            }
//        }
//
//        do {
//            let contentView = try context.factory(lego.content)
//            return contentView
//        } catch {
//            return EmptyView()
//        }
    }

}

public enum LegoViewRegistryError: Error {
    case unregisteredContentIdentifier(LegoBlockIdentifier)
    case contentTypeMismatch(expected: Any, actual: Any)
}

struct LegoViewFactoryEnvironmentKey: EnvironmentKey {

    static var defaultValue: LegoViewFactory { .shared }

}

extension EnvironmentValues {

    public var legoViewFactory: LegoViewFactory {
        get { self[LegoViewFactoryEnvironmentKey.self] }
        set { self[LegoViewFactoryEnvironmentKey.self] = newValue }
    }

}

extension View {

    public func legoViewFactory(_ legoViewFactory: LegoViewFactory) -> some View {
        environment(\.legoViewFactory, legoViewFactory)
    }

}




