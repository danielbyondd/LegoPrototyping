//
//  LegoActionRegistry.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public final class LegoActionRegistry {

    // MARK: Properties

    public static let shared = LegoActionRegistry()

    private var registeredActionTypes: [LegoActionIdentifier: any LegoAction.Type] = [:]

    // MARK: Init

    public init() { }

    // MARK: Public Functions

    public func register<Action>(_ actionType: Action.Type) where Action: LegoAction {
        registeredActionTypes[Action.identifier] = actionType
    }

    // MARK: Internal Functions

    func actionType(forIdentifier identifier: LegoActionIdentifier) throws -> any LegoAction.Type {
        guard let type = registeredActionTypes[identifier] else {
            throw LegoActionRegistryError.unregisteredActionIdentifier(identifier)
        }
        return type
    }

}
