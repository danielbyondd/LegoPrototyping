//
//  LegoBlock.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct LegoBlock: Identifiable {

    public let id: String
    public let type: String
    public let content: any LegoBlockContent
    public let logging: LegoLoggingInfo?

    public var typeIdentifier: LegoBlockIdentifier { .init(name: type) }

    public init(
        responseLego: ResponseLegoBlock,
        legoFactory: LegoBlockFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        self.id = responseLego.id
        self.type = responseLego.type

        let identifier = LegoBlockIdentifier(name: responseLego.type)
        let legoContentType = try LegoBlockContentRegistry.shared.contentType(forIdentifier: identifier)
        let legoResponseType = try LegoBlockContentRegistry.shared.responseContentType(forIdentifier: identifier)
        let responseContent = try Self.unwrap(legoResponseType, object: responseLego.content)

        let logging = responseLego.logging?.combine(with: parentLoggingInfo)
        self.content = try Self.makeContent(legoContentType.self, responseContent: responseContent, legoFactory: legoFactory, parentLoggingInfo: logging)

        self.logging = logging
    }

    /// Dealing with an `any LegoContent.Type` means we can't use it directly to `as?` cast, so we need to create a generic
    /// function to act as a resolution/unwrapping layer.
    private static func unwrap<T>(_: T.Type, object: Any) throws -> T where T: LegoResponseContent {
        guard let unwrapped = object as? T else {
            throw LegoError.legoContentTypeMismatch(expected: T.self, actual: Swift.type(of: object))
        }
        return unwrapped
    }

    /// Similar to the `unwrap` function, we need a way to use the content type to cast the response content as well as call the init
    private static func makeContent<Content>(_: Content.Type, responseContent: any LegoResponseContent, legoFactory: LegoBlockFactory, parentLoggingInfo: LegoLoggingInfo?) throws -> Content where Content: LegoBlockContent {
        guard let responseContent = responseContent as? Content.ResponseContent else {
            throw LegoError.legoContentTypeMismatch(expected: Content.ResponseContent.self, actual: Swift.type(of: responseContent))
        }
        return try Content.init(responseContent: responseContent, legoFactory: legoFactory, parentLoggingInfo: parentLoggingInfo)
    }

}

extension LegoBlock: Equatable {

    public static func == (lhs: LegoBlock, rhs: LegoBlock) -> Bool {
        return lhs.id == rhs.id
        && lhs.type == rhs.type
        && lhs.content.isEqual(to: rhs.content)
        && lhs.logging == rhs.logging
    }

}

extension LegoBlock: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(type)
        hasher.combine(content)
        hasher.combine(logging)
    }

}
