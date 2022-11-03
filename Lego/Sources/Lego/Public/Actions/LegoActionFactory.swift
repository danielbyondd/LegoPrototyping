//
//  LegoActionFactory.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public final class LegoActionFactory {

    // MARK: Properties

    private var registeredDataProviders: [LegoActionIdentifier: LegoActionUserInterfaceDataProvider] = [:]

    // MARK: Init

    public init() { }

    // MARK: Public Functions

    public func registerDataProvider<Action>(
        for _: Action.Type,
        provider: @escaping (Action.Content) async throws -> Action.UserInterfaceData
    ) where Action: LegoAction {
        // TODO: Add logging if already registered, might result in unexpected behavior
        registeredDataProviders[Action.identifier] = .init(Action.self, provider: provider)
    }

    public func executeAction<Action>(_ action: Action) async throws where Action: LegoAction {
        let dataProvider = try dataProvider(for: action.identifier)
        let userInterfaceData = try await dataProvider.provideUserInterfaceData(for: action)
        try await action.execute(userInterfaceData: userInterfaceData)
    }

    // MARK: Private Functions

    private func dataProvider(for identifier: LegoActionIdentifier) throws -> LegoActionUserInterfaceDataProvider {
        guard let provider = registeredDataProviders[identifier] else {
            throw LegoActionUserInterfaceDataProviderError.unregisteredIdentifier(identifier)
        }
        return provider
    }

}

public enum LegoActionUserInterfaceDataProviderError: Error {
    case unexpectedActionType(any LegoAction)
    case unexpectedUserInterfaceDataType(Any)
    case unregisteredIdentifier(LegoActionIdentifier)
}

public struct LegoActionUserInterfaceDataProvider {

    private let wrappedProvider: (any LegoAction) async throws -> Any

    public init<Action>(
        _: Action.Type,
        provider: @escaping (Action.Content) async throws -> Action.UserInterfaceData
    ) where Action: LegoAction {
        self.wrappedProvider = { action in
            guard let action = action as? Action else {
                throw LegoActionUserInterfaceDataProviderError.unexpectedActionType(action)
            }
            let actionData = action.content
            let userInterfaceData = try await provider(actionData)
            return userInterfaceData
        }
    }

    func provideUserInterfaceData<Action>(for action: Action) async throws -> Action.UserInterfaceData where Action: LegoAction {
        let userInterfaceData = try await wrappedProvider(action)
        guard let userInterfaceData = userInterfaceData as? Action.UserInterfaceData else {
            throw LegoActionUserInterfaceDataProviderError.unexpectedUserInterfaceDataType(userInterfaceData)
        }
        return userInterfaceData
    }

}
