//
//  StoreRatingsCarouselView.swift
//  
//
//  Created by Daniel Byon on 12/1/22.
//

import Lego
import StoreDomainInterface
import SwiftUI

public struct StoreRatingsCarouselView: View {

    private let content: StoreRatingsCarousel

    public var body: some View {
        VStack(alignment: .leading) {
            Text("\(content.maxNumberOfStars)")
            
        }
    }

}

//struct StoreRatingsCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreRatingsCarouselView()
//    }
//}
