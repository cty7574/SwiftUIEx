//
//  ChipsView.swift
//  ChipsSelection
//
//  Created by 멘태 on 12/3/25.
//

import SwiftUI

struct ChipsView<Content: View, Tag: Equatable>: View where Tag: Hashable {
    var spacing: CGFloat = 10
    var tags: [Tag]
    @ViewBuilder var content: (Tag, Bool) -> Content
    var didChangeSelection: ([Tag]) -> ()
    @State private var selectedTags: [Tag] = []
    
    var body: some View {
        Text("Hello, world!")
    }
}

#Preview {
    ContentView()
}
