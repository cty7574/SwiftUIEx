//
//  LiquidStyleView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI

struct LiquidStyleView: View {
    var body: some View {
        VStack {
            // Liquid Glass Button
            Button("Tap Me") {
                
            }
            .buttonStyle(.glass)
            
            // 커스텀 뷰에 liquid 스타일 적용
            Image(systemName: "suit.heart.fill")
                .font(.largeTitle)
                .foregroundStyle(.red.gradient)
                .frame(width: 50, height: 50)
                // 상호작용 가능한 glass effect
                //.glassEffect(.regular.interactive(), in: .circle)
                .glassEffect(.regular.tint(.red.opacity(0.35)).interactive(), in: .circle) // 배경색 적용
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

#Preview {
    LiquidStyleView()
}
