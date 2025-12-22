//
//  AnimatedBottomBar.swift
//  AnimatedBottomBar
//
//  Created by 멘태 on 12/22/25.
//

import SwiftUI

struct AnimatedBottomBar<LeadingAction: View, TrailingAction: View, MainAction: View>: View {
    var hint: String
    var tint: Color = .green
    
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    @ViewBuilder var leadingAction: () -> LeadingAction
    @ViewBuilder var trailingAction: () -> TrailingAction
    @ViewBuilder var mainAction: () -> MainAction
    
    var body: some View {
        let mainLayout = isFocused
        ? AnyLayout(ZStackLayout(alignment: .bottomTrailing))
        : AnyLayout(HStackLayout(alignment: .bottom, spacing: 10))
        
        let shape: RoundedRectangle = .init(cornerRadius: isFocused ? 25 : 30)
        
        ZStack {
            mainLayout {
                let subLayout = isFocused
                ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 20))
                : AnyLayout(ZStackLayout(alignment: .trailing))
                
                subLayout {
                    TextField(hint, text: $text, axis: .vertical)
                        .lineLimit(5)
                        .focused(_isFocused)
                    
                    HStack(spacing: 10) {
                        HStack(spacing: 10) {
                            ForEach(subviews: leadingAction()) { subview in
                                subview
                                    .frame(width: 35, height: 35)
                                    .contentShape(.rect)
                            }
                        }
                        .compositingGroup()
                        .allowsHitTesting(isFocused)
                        .blur(radius: isFocused ? 0 : 6)
                        .opacity(isFocused ? 1 : 0)
                        
                        Spacer(minLength: 0)
                        
                        trailingAction()
                            .frame(width: 35, height: 35)
                            .contentShape(.rect)
                    }
                }
                .frame(height: isFocused ? nil : 55)
                .padding(.leading)
                .padding(.trailing, isFocused ? 16 : 10)
                .padding(.bottom, isFocused ? 10 : 0)
                .padding(.top, isFocused ? 20 : 0)
                .background {
                    shape
                        .fill(.bar)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: -5)
                }
                
                mainAction()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                    .background {
                        Circle()
                            .fill(.bar)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: -5)
                    }
                    .visualEffect { [isFocused] content, proxy in
                        content
                            .offset(x: isFocused ? (proxy.size.width + 30) : 0)
                    }
                    
            }
        }
        .geometryGroup()
        .animation(.linear(duration: 1), value: isFocused)
    }
    
}
    
#Preview {
    ContentView()
}
