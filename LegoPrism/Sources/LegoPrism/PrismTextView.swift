//
//  PrismTextView.swift
//  
//
//  Created by Daniel Byon on 11/29/22.
//

import SwiftUI

public struct PrismTextView: View {

    private let content: PrismText

    public var body: some View {
        Text(content.text)
    }

    public init(content: PrismText) {
        self.content = content
    }

}

struct PrismTextView_Previews: PreviewProvider {
    static var previews: some View {
        PrismTextView(content: .init(text: "Hello World", style: "mobile/title1", color: "text/primary"))
    }
}
