//
//  StoreCarouselSquareItemView.swift
//  
//
//  Created by Daniel Byon on 12/1/22.
//

import Lego
import StoreDomainInterface
import SwiftUI

struct StoreCarouselSquareItemView: View {

    private let content: StoreCarouselRectangularItem

    public var body: some View {
        VStack(alignment: .leading) {
            Text(content.name)
            Text(content.description)
        }
    }

    public init(content: StoreCarouselRectangularItem) {
        self.content = content
    }

}

//struct StoreCarouselSquareItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreCarouselSquareItemView()
//    }
//}
