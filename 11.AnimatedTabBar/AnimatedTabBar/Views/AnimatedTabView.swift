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
    @State private var imageViews: [Selection: UIImageView] = [:]
    
    var effects: (Selection) -> [any DiscreteSymbolEffect & SymbolEffect]
    
    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.tabBarOnly)
        .background {
            ExtractImageViewsFromTabView {
                imageViews = $0
            }
        }
        .compositingGroup()
        .onChange(of: selection) { oldValue, newValue in
            let symbolEffects = effects(newValue)
            guard let imageView = imageViews[newValue] else { return }
            
            for effect in symbolEffects {
                imageView.addSymbolEffect(effect, options: .nonRepeating)
            }
        }
    }
}

#Preview {
    ContentView()
}
