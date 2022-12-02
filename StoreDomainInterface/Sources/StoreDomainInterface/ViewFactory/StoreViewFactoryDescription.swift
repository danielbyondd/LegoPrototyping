//
//  StoreViewFactoryDescription.swift
//  
//
//  Created by Daniel Byon on 11/28/22.
//

import Foundation
import Lego

public enum StoreViewFactoryDescription: LegoViewFactoryDescription {

    case carousel(StoreCarousel)

    public static var identifier: String { "ox.store" }

}
