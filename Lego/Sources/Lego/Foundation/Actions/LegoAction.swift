//
//  LegoAction.swift
//  
//
//  Created by Daniel Byon on 11/2/22.
//

import Foundation

public protocol LegoAction<Content, UserInterfaceData>: Codable, AnyEquatable, Hashable {

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

public func == (lhs: [any LegoAction], rhs: [any LegoAction]) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }
    return zip(lhs, rhs)
        .allSatisfy { l, r in
            l.isEqual(to: r)
        }
}

extension Array<any LegoAction> {

    public var hashValue: Int {
        map(\.hashValue).hashValue
    }

}
