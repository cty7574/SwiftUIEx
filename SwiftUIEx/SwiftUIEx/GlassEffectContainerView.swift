//
//  GlassEffectContainerView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI

struct GlassEffectContainerView: View {
    @State private var isExpanded: Bool = false
    @Namespace private var animation
    
    var body: some View {
        Color.gray
            .overlay(alignment: .bottom) {
                GlassEffectContainer {
                    VStack {
                        if isExpanded {
                            Group {
                                Image(systemName: "suit.heart.fill")
                                    .font(.title)
                                    .foregroundStyle(.white.gradient)
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundStyle(.white.gradient)
                                    .frame(width: 50, height: 50)
                            }
                            .glassEffect(.regular, in: .circle)
                            //.glassEffectTransition(.identity) // 애니메이션 비활성화
                            // --- 통합 글래스 효과 ---
                            //.glassEffect(.regular, in: .capsule)
                            //.glassEffectUnion(id: "Group-1", namespace: animation)
                            
                        }
                        
                        Button {
                            withAnimation(.smooth(duration: 1, extraBounce: 0)) {
                                isExpanded.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title)
                                .foregroundStyle(.white.gradient)
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(.glass)
                    }
                    .padding()
                }
            }
    }
}

#Preview {
    GlassEffectContainerView()
}
