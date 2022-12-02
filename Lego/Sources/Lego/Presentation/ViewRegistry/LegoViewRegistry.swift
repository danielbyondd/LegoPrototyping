//
//  LegoViewRegistry.swift
//  
//
//  Created by Daniel Byon on 11/28/22.
//

import SwiftUI

public final class LegoViewRegistry {

    public static let shared = LegoViewRegistry()

    private var registeredLegos: [LegoBlockIdentifier: (any LegoBlockContent) throws -> any LegoContentView] = [:]
    private var registeredContentTypes: [LegoBlockIdentifier: any LegoBlockContent.Type] = [:]
    private var registeredContentViewTypes: [LegoBlockIdentifier: any View.Type] = [:]

    public init() { }

    public func register<Content, ContentView>(
        _ contentType: Content.Type,
        _ contentViewType: ContentView.Type,
        forIdentifier identifier: LegoBlockIdentifier
    ) where Content: LegoBlockContent, ContentView: View {
        registeredContentTypes[identifier] = contentType
        registeredContentViewTypes[identifier] = contentViewType
    }

    func makeLegoContentView(for lego: LegoBlock) -> any View {
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
    case unregisteredContentIdentifier(LegoBlockIdentifier)
}
