//
//  StoreMenuCategoryView.swift
//  
//
//  Created by Daniel Byon on 12/1/22.
//

import Lego
import StoreDomainInterface
import SwiftUI

public struct StoreMenuCategoryView: View {

    private let content: StoreMenuCategory

    public var body: some View {
        List {
            Section {
                ForEach(content.children) { lego in
                    LegoView(lego: lego)
                }
            } header: {
                LegoView(lego: content.header)
            }
        }
    }

}

//struct StoreMenuCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreMenuCategoryView()
//    }
//}
