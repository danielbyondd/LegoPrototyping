//
//  LegoBlockContentRegistry.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public final class LegoBlockContentRegistry {

    // MARK: Properties

    // TODO: Make this not a singleton and an injected service in Cx
    public static let shared = LegoBlockContentRegistry()

    private var registeredContentTypes: [LegoBlockIdentifier: any LegoBlockContent.Type] = [:]
    private var registeredResponseContentTypes: [LegoBlockIdentifier: any LegoResponseContent.Type] = [:]

    // MARK: Init

    public init() { }

    // MARK Public Functions

    public func register<Content>(_ contentType: Content.Type, forIdentifier identifier: LegoBlockIdentifier) where Content: LegoBlockContent {
        // TODO: Add logging if already registered, might result in unexpected behavior
        registeredContentTypes[identifier] = contentType
        registeredResponseContentTypes[identifier] = contentType.ResponseContent
    }

    // MARK: Internal Functions

    func contentType(forIdentifier identifier: LegoBlockIdentifier) throws -> any LegoBlockContent.Type {
        guard let type = registeredContentTypes[identifier] else {
            throw LegoBlockContentRegistryError.unregisteredContentIdentifier(identifier)
        }
        return type
    }

    func responseContentType(forIdentifier identifier: LegoBlockIdentifier) throws -> any LegoResponseContent.Type {
        guard let type = registeredResponseContentTypes[identifier] else {
            throw LegoBlockContentRegistryError.unregisteredContentIdentifier(identifier)
        }
        return type
    }

}
