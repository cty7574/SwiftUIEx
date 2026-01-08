//
//  MiniatureAction.swift
//  ExpandableMenus
//
//  Created by 멘태 on 1/7/26.
//

import SwiftUI

struct MiniatureActionView<Actions: View, Background: View>: View {
    var innerScaling: CGFloat = 1
    var minimisedButtonSize: CGSize = .init(width: 50, height: 50)
    var animation: Animation
    
    @Binding var isPresented: Bool 
    
    @ViewBuilder var actions: Actions
    @ViewBuilder var background: Background
    
    var body: some View {
        actions
            .allowsHitTesting(isPresented)
            .contentShape(.rect)
            .compositingGroup()
            .visualEffect({ [innerScaling, minimisedButtonSize, isPresented] content, proxy in
                let maxValue = max(proxy.size.width, proxy.size.height)
                let minButtonValue = min(minimisedButtonSize.width, minimisedButtonSize.height)
                let fitScale = minButtonValue / maxValue
                let modifiedInnerScale = 0.55 * innerScaling
                
                return content
                    .scaleEffect(isPresented ? 1 : modifiedInnerScale)
                    .scaleEffect(isPresented ? 1 : fitScale)
            })
            .overlay {
                if !isPresented {
                    Capsule()
                        .foregroundStyle(.clear)
                        .frame(width: minimisedButtonSize.width, height: minimisedButtonSize.height)
                        .contentShape(.capsule)
                        .onTapGesture {
                            isPresented = true
                        }
                        .transition(.identity)
                }
            }
            .background {
                background
                    .frame(width: minimisedButtonSize.width, height: minimisedButtonSize.height)
            }
            .fixedSize()
            .frame(
                width: isPresented ? nil : minimisedButtonSize.width,
                height: isPresented ? nil : minimisedButtonSize.height
            )
            .animation(animation, value: isPresented)
    }
}

#Preview {
    ContentView()
}
