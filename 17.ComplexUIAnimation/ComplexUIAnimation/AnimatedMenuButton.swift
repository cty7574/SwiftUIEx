//
//  AnimatedMenuButton.swift
//  ComplexUIAnimation
//
//  Created by 멘태 on 1/15/26.
//

import SwiftUI

struct AnimatedMenuButton: View {
    @Binding var disableBottomBar: Bool
    var isRecording: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isRecording || disableBottomBar {
                    Image(systemName: "mic")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.primary)
                        .transition(.scale(0.5).combined(with: .opacity))
                } else {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.primary)
                        .transition(.scale(0.5).combined(with: .opacity))
                }
            }
            .frame(width: 30)
        }
        .allowsHitTesting(!isRecording)
        .animation(.easeInOut(duration: 0.3), value: isRecording)
        .animation(.easeInOut(duration: 0.3), value: disableBottomBar)
    }
}
