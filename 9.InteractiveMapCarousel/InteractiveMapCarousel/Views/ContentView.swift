//
//  ContentView.swift
//  InteractiveMapCarousel
//
//  Created by 멘태 on 12/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showView: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Button("Show View") {
                    showView.toggle()
                }
            }
            .navigationTitle("Map Carousel")
        }
        .fullScreenCover(isPresented: $showView) {
            CustomMapView()
        }
    }
}

#Preview {
    ContentView()
}
