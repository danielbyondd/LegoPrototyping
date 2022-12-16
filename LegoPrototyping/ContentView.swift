//
//  ContentView.swift
//  LegoPrototyping
//
//  Created by Daniel Byon on 11/1/22.
//

import SwiftUI
import Lego
import LegoConsumer
import LegoPrism
import StoreDomainInterface
import Store

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            StorePage(page: viewModel.page)
        }
        .navigationTitle("Lego 2.0 Prototype")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class ContentViewModel: ObservableObject {

    let page: LegoPage = {
        let data = try! Fixture.loadJSONData(named: "contract-sample-1")
        let decoder = JSONDecoder()
        let responsePage = try! decoder.decode(ResponsePage.self, from: data)
        let page = try! LegoPage(responsePage: responsePage)
        return page
    }()

    init() { }

}
