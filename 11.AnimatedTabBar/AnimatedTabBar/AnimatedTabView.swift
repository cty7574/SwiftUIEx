//
//  AnimatedTabView.swift
//  AnimatedTabBar
//
//  Created by 멘태 on 12/17/25.
//

import SwiftUI

protocol AnimatedTabSelectionProtocol: CaseIterable, Hashable {
    var title: String { get }
    var symbolImage: String { get }
}

struct AnimatedTabView<Selection: AnimatedTabSelectionProtocol, Content: TabContent<Selection>>: View {
    @Binding var selection: Selection
    @TabContentBuilder<Selection> var content: () -> Content
    
    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.tabBarOnly)
    }
}

#Preview {
    ContentView()
}
