//
//  ContentView.swift
//  ExpandableMenus
//
//  Created by 멘태 on 1/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    
    var animation: Animation {
        .smooth(duration: 0.5, extraBounce: 0)
    }
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("iPhone Guide") {
                    
                }
                
                NavigationLink("iPad Guide") {
                    
                }
            }
            .navigationTitle("Apple Books")
        }
        .overlay {
            MiniatureActionView(animation: animation, isPresented: $isPresented) {
                actionContent()
            } background: {
                
            }

        }
    }
    
    @ViewBuilder
    private func actionContent() -> some View {
        VStack(spacing: 10) {
            CustomButton(title: "Search Book", symbol: "magnifyingglass")
                .frame(width: 250, height: 45)
            
            CustomButton(title: "Themes & Settings", symbol: "textformat.size")
                .frame(width: 250, height: 45)
            
            HStack(spacing: 10) {
                CustomSectionButton(symbol: "square.and.arrow.up")
                CustomSectionButton(symbol: "lock.rotation")
                CustomSectionButton(symbol: "text.line.magnify")
                CustomSectionButton(symbol: "bookmark")
            }
            .font(.title3)
            .fontWeight(.medium)
            .frame(width: 250, height: 45)
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    ContentView()
}
