//
//  SlideToCancelText.swift
//  ComplexUIAnimation
//
//  Created by 멘태 on 1/14/26.
//

import SwiftUI

struct SlideToCancelText: View {
    var text: String
    @State private var animate: Bool = false
    
    var body: some View {
        viewContent()
            .foregroundStyle(.gray.secondary)
            .overlay {
                viewContent()
                    .foregroundStyle(.primary)
                    .mask {
                        GeometryReader { proxy in
                            let size: CGSize = proxy.size
                            
                            Rectangle()
                                .frame(width: 15, height: size.width)
                                .blur(radius: 5)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .offset(x: animate ? -size.width * 1.1 : 30)
                        }
                    }
            }
            .compositingGroup()
            .onAppear {
                guard !animate else { return }
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                    animate = true
                }
            }
    }
    
    @ViewBuilder
    private func viewContent() -> some View {
        HStack(spacing: 5) {
            Image(systemName: "chevron.left")
                .font(.caption)
            
            Text(text)
                .font(.callout)
        }
    }
}

#Preview {
    SlideToCancelText(text: "Slide to cancel")
}
