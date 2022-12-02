//
//  CarouselView.swift
//  
//
//  Created by Daniel Byon on 11/21/22.
//

import Lego
import SwiftUI

public struct CarouselView: View {

    public let content: Carousel

    public var body: some View {
        VStack {
            Text(content.header.id)

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(content.children, id: \.id) { child in
                        Text(child.id)
                    }
                }
            }
        }
    }

    public init(content: Carousel) {
        self.content = content
    }

}

//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}
