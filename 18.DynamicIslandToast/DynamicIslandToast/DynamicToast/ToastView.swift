//
//  ToastView.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

struct ToastView: View {
    var window: PassThroughWindow
    
    var isExpanded: Bool {
        return window.isPresented
    }
    
    var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets
            let size = proxy.size
            
            let dynamicIslandWidth: CGFloat = 120
            let dynamicIslandHeight: CGFloat = 36
            let topOffset: CGFloat = 11 + (max(safeArea.top - 59, 0))
            
            let expandedWidth = size.width - 20
            let expandedHeight: CGFloat = 90
            
            ZStack {
                ConcentricRectangle(corners: .concentric(minimum: .fixed(30)), isUniform: true)
                    .fill(.black)
                    .frame(
                        width: isExpanded ? expandedWidth : dynamicIslandWidth,
                        height: isExpanded ? expandedHeight : dynamicIslandHeight
                    )
                    .offset(y: topOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .animation(.bouncy(duration: 0.3, extraBounce: 0), value: isExpanded)
        }
    }
}

#Preview {
    ContentView()
}
