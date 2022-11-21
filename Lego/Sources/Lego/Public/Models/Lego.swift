//
//  Lego.swift
//  
//
//  Created by Daniel Byon on 11/17/22.
//

import Foundation

public struct Lego {

    public let id: String
    public let type: String
    public let content: any LegoContent
    public let logging: LegoLoggingInfo?

    public init(
        responseLego: ResponseLego,
        legoFactory: LegoFactory,
        parentLoggingInfo: LegoLoggingInfo?
    ) throws {
        self.id = responseLego.id
        self.type = responseLego.type

        let identifier = LegoContentIdentifier(name: responseLego.type)
        let legoContentType = try LegoContentRegistry.shared.contentType(forIdentifier: identifier)
        let legoResponseType = try LegoContentRegistry.shared.responseContentType(forIdentifier: identifier)
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
    private static func makeContent<Content>(_: Content.Type, responseContent: any LegoResponseContent, legoFactory: LegoFactory, parentLoggingInfo: LegoLoggingInfo?) throws -> Content where Content: LegoContent {
        guard let responseContent = responseContent as? Content.ResponseContent else {
            throw LegoError.legoContentTypeMismatch(expected: Content.ResponseContent.self, actual: Swift.type(of: responseContent))
        }
        return try Content.init(responseContent: responseContent, legoFactory: legoFactory, parentLoggingInfo: parentLoggingInfo)
    }

}
