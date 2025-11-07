//
//  CustomTabView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            Tab.init("Home", systemImage: "house.fill") {
                ScrollView {
                    ForEach(0 ..< 50) { index in
                        Text("\(index)")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                    }
                }
            }
            
            Tab.init("Favorite", systemImage: "suit.heart.fill") {
                Text("Favorites")
            }
            
            Tab.init("Settings", systemImage: "gearshape.fill") {
                Text("Settings")
            }
            
            Tab.init("Search", systemImage: "magnifyingglass", role: .search) {
                Text("Search")
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown) // 탭바 최소화
        .tabViewBottomAccessory {
            Text("Custom Music Player!")
                .padding()
        }
        
    }
}

#Preview {
    CustomTabView()
}
