//
//  PulseRingView.swift
//  InteractiveMapCarousel
//
//  Created by 멘태 on 12/10/25.
//

import SwiftUI

struct PulseRingView: View {
    var tint: Color
    var size: CGFloat
    
    @State private var animate: [Bool] = [false, false, false]
    @State private var showView: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            if showView {
                ZStack {
                    ringView(index: 0)
                    ringView(index: 1)
                    ringView(index: 2)
                }
                .onAppear {
                    for index in 0..<animate.count {
                        let delay: Double = Double(index) * 0.2
                        
                        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false).delay(delay)) {
                            animate[index] = true
                        }
                    }
                }
                .onDisappear {
                    animate = [false, false, false]
                }
            }
        }
        .onChange(of: scenePhase, initial: true) { oldValue, newValue in
            showView = newValue != .background
        }
        .frame(width: size, height: size)
    }
    
    @ViewBuilder
    private func ringView(index: Int) -> some View {
        Circle()
            .fill(tint)
            .opacity(animate[index] ? 0 : 0.4)
            .scaleEffect(animate[index] ? 2 : 0)
    }
}

#Preview {
    PulseRingView(tint: .primary, size: 100)
}
