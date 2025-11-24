//
//  ContentView.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
