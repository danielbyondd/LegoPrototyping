//
//  LegoActionExecutor.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public final class LegoActionExecutor {

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

    public func execute<Action>(_ action: Action) async throws where Action: LegoAction {
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
