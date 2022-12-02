//
//  LegoAction.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public protocol LegoAction<Content, UserInterfaceData>: Codable {

    associatedtype Content: LegoActionContent
    associatedtype UserInterfaceData

    static var identifier: LegoActionIdentifier { get }
    var content: Content { get }

    init(content: Content)

    func execute(userInterfaceData: UserInterfaceData) async throws

}

extension LegoAction {

    public var identifier: LegoActionIdentifier { Self.identifier }

}

extension LegoAction where UserInterfaceData == Void {

    public func execute() async throws {
        try await execute(userInterfaceData: ())
    }

}

public protocol LegoActionContent<CodingKeys>: Codable {

    associatedtype CodingKeys: CodingKey

}
