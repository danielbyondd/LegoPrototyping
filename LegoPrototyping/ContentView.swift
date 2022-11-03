//
//  ContentView.swift
//  LegoPrototyping
//
//  Created by Daniel Byon on 11/1/22.
//

import SwiftUI
import Lego

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
