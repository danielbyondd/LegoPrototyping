//
//  LegoViewRegistry.swift
//  
//
//  Created by Daniel Byon on 11/28/22.
//

import SwiftUI

public final class LegoViewRegistry {

    public static let shared = LegoViewRegistry()

    private var registeredLegos: [LegoIdentifier: (any LegoContent) throws -> any LegoContentView] = [:]
    private var registeredContentTypes: [LegoIdentifier: any LegoContent.Type] = [:]
    private var registeredContentViewTypes: [LegoIdentifier: any View.Type] = [:]

    public init() { }

    public func register<Content, ContentView>(
        _ contentType: Content.Type,
        _ contentViewType: ContentView.Type,
        forIdentifier identifier: LegoIdentifier
    ) where Content: LegoContent, ContentView: View {
        registeredContentTypes[identifier] = contentType
        registeredContentViewTypes[identifier] = contentViewType
    }

//    func contentType(forIdentifier identifier: LegoIdentifier) throws -> any LegoContent.Type {
//        guard let type = registeredContentTypes[identifier] else {
//            throw LegoViewRegistryError.unregisteredContentIdentifier(identifier)
//        }
//        return type
//    }
//
//    func contentViewType(forIdentifier identifier: LegoIdentifier) throws -> any View.Type {
//        guard let type = registeredContentViewTypes[identifier] else {
//            throw LegoViewRegistryError.unregisteredContentIdentifier(identifier)
//        }
//        return type
//    }

    func makeLegoContentView(for lego: Lego) -> any View {
        let identifier = lego.typeIdentifier
        guard let factory = registeredLegos[identifier] else {
            assertionFailure("No registered")
            return EmptyView()
        }

        do {
            let contentView = try factory(lego.content)
            return contentView
        } catch {
            return EmptyView()
        }
    }

}

public enum LegoViewRegistryError: Error {
    case unregisteredContentIdentifier(LegoIdentifier)
}
