//
//  NewModifiersView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/4/25.
//

import SwiftUI

struct NewModifiersView: View {
    @State private var progress: CGFloat = 0.2
    
    var body: some View {
        NavigationStack {
            List {
                GeometryReader { proxy in
                    let scale: CGFloat = 4
                    let width: CGFloat = proxy.size.width / scale
                    
                    Slider(value: $progress)
                        .sliderThumbVisibility(.hidden) // 1.sliderThumb 숨김
                        .frame(width: width)
                        .scaleEffect(scale, anchor: .leading) // 직접적인 크기 변경이 불가능.
                }
                .frame(height: 70)
                .padding(.horizontal)
                
                ForEach(1...10, id: \.self) { index in
                    NavigationLink("Go To View \(index)") {
                        
                    }
                    .navigationLinkIndicatorVisibility(.hidden) // 2.링크 인디케이터 숨김
                }
            }
            .navigationTitle("Document")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarTitleMenu { // 3.네비게이션 title 확장 - inline 모드에서만 가능
                Button("Copy") { }
                
                Button("Duplicate") { }
                
                Button("Delete", role: .destructive) { }
            }
            .safeAreaBar(edge: .bottom) { // 4.safeAreaInset과 유사하지만 아래 수정자를 통해 배경 이펙트를 제어할 수 있다.
                Text("Hello, This is Bottom Bar!")
                    .padding(.vertical)
            }
            .scrollEdgeEffectStyle(.soft, for: .bottom)
            //.toolbarTitleDisplayMode(.inlineLarge) // 5.Large title을 쓰면서 상단 여백이 필요없는 경우 사용
        }
    }
}

#Preview {
    NewModifiersView()
}
