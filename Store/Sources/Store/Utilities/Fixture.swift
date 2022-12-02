//
//  Fixture.swift
//  
//
//  Created by Daniel Byon on 11/1/22.
//

import Foundation
@testable import Lego

enum Fixture {

    static func loadJSONData(named name: String) throws -> Data {
        try loadData(named: name, withExtension: "json")
    }

    static func loadData(named name: String, withExtension extension: String? = nil) throws -> Data {
        let url = Bundle.module
            .url(forResource: name, withExtension: `extension`)!
        let data = try Data(contentsOf: url)
        return data
    }

}

private final class BundleMarker { }
