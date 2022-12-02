//
//  LegoActionUserInterfaceDataProvider.swift
//  
//
//  Created by Daniel Byon on 11/18/22.
//

import Foundation

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
