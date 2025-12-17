//
//  ContentView.swift
//  AnimatedTabBar
//
//  Created by 멘태 on 12/17/25.
//

import SwiftUI

enum AppTab: AnimatedTabSelectionProtocol {
    case call
    case notifications
    case settings
    
    var symbolImage: String {
        switch self {
        case .call: return "phone.down.waves.left.and.right"
        case .notifications: return "bell.badge"
        case .settings: return "gearshape.fill"
        }
    }
    
    var title: String {
        switch self {
        case .call: return "Call"
        case .notifications: return "Notifications"
        case .settings: return "Settings"
        }
    }
}

struct ContentView: View {
    @State private var activeTab: AppTab = .call
    
    var body: some View {
        AnimatedTabView(selection: $activeTab) {
            ForEach(AppTab.allCases, id: \.title) { tab in
                Tab(tab.title, systemImage: tab.symbolImage, value: tab) {
                    Text(tab.title)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
