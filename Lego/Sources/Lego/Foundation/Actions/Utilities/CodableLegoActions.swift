//
//  CodableLegoActions.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

@propertyWrapper
public struct CodableLegoActions: Codable {

    // MARK: Properties

    public let wrappedValue: [any LegoAction]

    // MARK: Private Types

    private enum CodingKeys: String, CodingKey {
        case type = "action_type"
        case content
    }

    // MARK: Init

    public init(wrappedValue: [any LegoAction]) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {

        func instantiateAction<T>(_: T.Type, with content: T.Content) -> some LegoAction where T: LegoAction {
            T.init(content: content)
        }

        /// Unkeyed containers keeps an internal cursor which is incremented on each decode() call.
        /// So we need two containers that we advance in each loop iteration:
        ///
        /// 1. The typeContainer is used to index into the container and extract the "action_type"
        /// property. This is used to look up the concrete LegoAction type from the action registry.
        ///
        /// 2. The actionsContainer is used to actually decode the action, using the type we fetched from
        /// the typeContainer
        var typeContainer = try decoder.unkeyedContainer()
        var actionsContainer = typeContainer

        var actions: [any LegoAction] = []
        while !typeContainer.isAtEnd {
            do {
                let actionContainer = try typeContainer.nestedContainer(keyedBy: CodingKeys.self)

                do {
                    let type = try actionContainer.decode(String.self, forKey: .type)

                    do {
                        let identifier = LegoActionIdentifier(name: type)
                        // TODO: Inject this as a service in Cx
                        let actionType = try LegoActionRegistry.shared.actionType(forIdentifier: identifier)
                        let action = try actionsContainer.decode(actionType)
                        actions.append(action)
                    } catch {
                        debugPrint("Failed to decode action of type '\(type)' with error: \(error)")
                    }
                } catch {
                    debugPrint("Failed to decode action type: \(error)")
                }
            } catch {
                debugPrint("Received unknown action: \(error)")
                continue
            }
        }
        self.wrappedValue = actions
    }

    // MARK: Functions

    public func encode(to encoder: Encoder) throws {
        var actionsContainer = encoder.unkeyedContainer()
        for action in wrappedValue {
            var container = actionsContainer.nestedContainer(keyedBy: CodingKeys.self)
            try container.encode(action.identifier.name, forKey: .type)
            try container.encode(action.content, forKey: .content)
        }
    }

}

extension CodableLegoActions: Equatable {

    public static func == (lhs: CodableLegoActions, rhs: CodableLegoActions) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }

}

extension CodableLegoActions: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue.hashValue)
    }

}

extension KeyedDecodingContainer {

    func decodeActionData<T>(_: T.Type, forKey key: Key) throws -> T.Content where T: LegoAction {
        try decode(T.Content.self, forKey: key)
    }

}
