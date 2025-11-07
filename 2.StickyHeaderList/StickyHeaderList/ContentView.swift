//
//  ContentView.swift
//  StickyHeaderList
//
//  Created by 멘태 on 11/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomList { progress in
            
        } topContent: { progress, safeAreaTop in
            heroImage(progress, safeAreaTop)
        } header: { progress in
            
        } content: {
            
        }

    }
    
    @ViewBuilder
    func heroImage(_ progress: CGFloat, _ safeAreaTop: CGFloat) -> some View {
        GeometryReader { proxy in
            let size: CGSize = proxy.size
            
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
        }
        .frame(height: 250)
    }
}

#Preview {
    ContentView()
}
