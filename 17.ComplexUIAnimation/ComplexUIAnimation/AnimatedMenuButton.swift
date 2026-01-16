//
//  AnimatedMenuButton.swift
//  ComplexUIAnimation
//
//  Created by 멘태 on 1/15/26.
//

import SwiftUI

struct AnimatedMenuButton: View {
    @Binding var disableBottomBar: Bool
    @State private var keyFrameTrigger: Bool = false
    @State private var isTrashOpen: Bool = false
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
                        .keyframeAnimator(initialValue: KeyFrame(), trigger: keyFrameTrigger) { content, frame in
                            content
                                .scaleEffect(frame.scale, anchor: .bottom)
                                .rotationEffect(.init(degrees: frame.rotation))
                                .offset(y: frame.offset)
                                .opacity(frame.opacity)
                        } keyframes: { _ in
                            CubicKeyframe(KeyFrame(offset: -50, rotation: 360), duration: 0.25)
                            CubicKeyframe(KeyFrame(scale: 0.5, offset: 0, rotation: 360), duration: 0.25)
                            CubicKeyframe(KeyFrame(opacity: 0, scale: 0.5, offset: 0, rotation: 360), duration: 0.1)
                        }

                } else {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.primary)
                        .transition(.scale(0.5).combined(with: .opacity))
                }
                
                customTrashCanView(isTrashOpen)
                    .keyframeAnimator(initialValue: KeyFrame(opacity: 0, scale: 0.5), trigger: keyFrameTrigger) { content, frame in
                        content
                            .scaleEffect(frame.scale)
                            .opacity(frame.opacity)
                    } keyframes: { _ in
                        CubicKeyframe(KeyFrame(scale: 1), duration: 0.2)
                        CubicKeyframe(KeyFrame(scale: 1), duration: 0.2)
                        CubicKeyframe(KeyFrame(opacity: 0, scale: 0.5), duration: 0.2)
                    }

            }
            .frame(width: 30)
        }
        .allowsHitTesting(!isRecording)
        .animation(.easeInOut(duration: 0.3), value: isRecording)
        .animation(.easeInOut(duration: 0.3), value: disableBottomBar)
        .onChange(of: disableBottomBar) { oldValue, newValue in
            if newValue {
                keyFrameTrigger.toggle()
                
                Task { @MainActor in
                    isTrashOpen = true
                    
                    try? await Task.sleep(for: .seconds(0.5))
                    isTrashOpen = false
                    try? await Task.sleep(for: .seconds(0.2))
                    disableBottomBar = false
                }
            }
        }
    }
    
    @ViewBuilder
    func customTrashCanView(_ isOpen: Bool) -> some View {
        VStack(spacing: 2) {
            VStack(spacing: 0) {
                UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 10)
                    .frame(width: 15, height: 6)
                
                Capsule()
                    .frame(height: 4)
            }
            .compositingGroup()
            .rotationEffect(.init(degrees: isOpen ? -90 : 0), anchor: .bottomLeading)
            .offset(y: isOpen ? 10 : 0)
            
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 5, bottomTrailingRadius: 5, topTrailingRadius: 0)
                .frame(width: 20, height: 20)
        }
        .frame(width: 25)
        .foregroundStyle(.gray)
        .compositingGroup()
        .scaleEffect(0.8)
        .animation(.easeInOut(duration: 0.3), value: isOpen)
    }
    
    @Animatable
    struct KeyFrame {
        var opacity: CGFloat = 1.0
        var scale: CGFloat = 1.0
        var offset: CGFloat = 0.0
        var rotation: CGFloat = 0.0
    }
}
