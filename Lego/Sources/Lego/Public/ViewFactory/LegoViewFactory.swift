//
//  LegoViewFactory.swift
//  
//
//  Created by Daniel Byon on 11/21/22.
//

import Foundation
import SwiftUI

public protocol LegoViewFactory: View {

    var lego: Lego { get }
    
}




public protocol LegoViewFactoryDescription {

    static var identifier: String { get }

}

extension LegoViewFactoryDescription {

    var identifier: String { Self.identifier }

}
