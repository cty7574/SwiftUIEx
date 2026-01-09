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
        .smooth(duration: 0.35, extraBounce: 0)
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
        .overlay() {
            ZStack(alignment: .bottomTrailing) {
                Rectangle()
                    .fill(.primary.opacity(isPresented ? 0.2 : 0))
                    .allowsHitTesting(isPresented)
                    .onTapGesture {
                        isPresented = false
                    }
                    .animation(animation, value: isPresented)
                    .ignoresSafeArea()
                
                MiniatureActionView(animation: animation, isPresented: $isPresented) {
                    actionContent()
                } background: {
                    ZStack {
                        Capsule()
                            .fill(.background)
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                    }
                    .shadow(color: .gray.opacity(0.5), radius: 1)
                }
                .padding(.trailing)
                .padding(.bottom, 10)
            }
        }
    }
    
    @ViewBuilder
    private func actionContent() -> some View {
        VStack(spacing: 10) {
            CustomButton(title: "Search Book", symbol: "magnifyingglass", isPresented: $isPresented)
                .frame(width: 250, height: 45)
            
            CustomButton(title: "Themes & Settings", symbol: "textformat.size", isPresented: $isPresented)
                .frame(width: 250, height: 45)
            
            HStack(spacing: 10) {
                CustomSectionButton(symbol: "square.and.arrow.up", isPresented: $isPresented)
                CustomSectionButton(symbol: "lock.rotation", isPresented: $isPresented)
                CustomSectionButton(symbol: "text.line.magnify", isPresented: $isPresented)
                CustomSectionButton(symbol: "bookmark", isPresented: $isPresented)
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
