//
//  CarouselHeaderView.swift
//  
//
//  Created by Daniel Byon on 11/29/22.
//

import Lego
import LegoPrism
import SwiftUI

public struct CarouselHeaderView: View {

    private let content: CarouselHeader

    public var body: some View {
        VStack(alignment: .leading) {
            PrismTextView(content: content.title)
            if let subtitle = content.subtitle {
                PrismTextView(content: subtitle)
            }
        }
    }

    public init(content: CarouselHeader) {
        self.content = content
    }

}

//struct CarouselHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselHeaderView()
//    }
//}
