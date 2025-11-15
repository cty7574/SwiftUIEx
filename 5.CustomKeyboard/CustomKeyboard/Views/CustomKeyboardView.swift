//
//  CustomKeyboardView.swift
//  CustomKeyboard
//
//  Created by 멘태 on 11/15/25.
//

import SwiftUI

struct CustomKeyboardView: View {
    @Binding var text: String
    @FocusState.Binding var isActive: Bool
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 16) {
            ForEach(1...9, id: \.self) { index in
                buttonView("\(index)")
            }
        }
        .padding()
        .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)))
    }
    
    @ViewBuilder
    func buttonView(_ value: String, isImage: Bool = false) -> some View {
        Button {
            text += value
        } label: {
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 50, height: 50)
                .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 3, x: 0, y: 0)), in: .rect(cornerRadius: 10))
                .foregroundStyle(.primary)
        }

    }
}
