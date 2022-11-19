//
//  LegoContentRegistry.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation

public final class LegoContentRegistry {

    // MARK: Properties

    // TODO: Make this not a singleton and an injected service in Cx
    public static let shared = LegoContentRegistry()

    private var registeredContentTypes: [LegoContentIdentifier: any LegoContent.Type] = [:]
    private var registeredResponseContentTypes: [LegoContentIdentifier: any LegoResponseContent.Type] = [:]

    // MARK: Init

    public init() { }

    // MARK Public Functions

    public func register<Content>(_ contentType: Content.Type, forIdentifier identifier: LegoContentIdentifier) where Content: LegoContent {
        // TODO: Add logging if already registered, might result in unexpected behavior
        registeredContentTypes[identifier] = contentType
        registeredResponseContentTypes[identifier] = contentType.ResponseContent
    }

    // MARK: Internal Functions

    func contentType(forIdentifier identifier: LegoContentIdentifier) throws -> any LegoContent.Type {
        guard let type = registeredContentTypes[identifier] else {
            throw LegoContentRegistryError.unregisteredContentIdentifier(identifier)
        }
        return type
    }

    func responseContentType(forIdentifier identifier: LegoContentIdentifier) throws -> any LegoResponseContent.Type {
        guard let type = registeredResponseContentTypes[identifier] else {
            throw LegoContentRegistryError.unregisteredContentIdentifier(identifier)
        }
        return type
    }

}
