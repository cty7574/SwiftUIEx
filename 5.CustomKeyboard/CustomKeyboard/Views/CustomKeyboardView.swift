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
            
            buttonView("delete.backward.fill", isImage: true)
            buttonView("0")
            buttonView("checkmark.circle.fill", isImage: true)
        }
        .padding()
        .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)))
    }
    
    @ViewBuilder
    func buttonView(_ value: String, isImage: Bool = false) -> some View {
        Button {
            if isImage {
                if value == "delete.backward.fill" && !text.isEmpty {
                    text.removeLast()
                }
                
                if value == "checkmark.circle.fill" {
                    isActive = false
                }
            } else {
                text += value
            }
        } label: {
            Group {
                if isImage {
                    Image(systemName: value)
                } else {
                    Text(value)
                }
            }
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 50, height: 50)
            .background(content: {
                if !isImage {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.background.shadow(.drop(color: .black.opacity(0.08), radius: 3, x: 0, y: 0)))
                }
            })
            .foregroundStyle(.black)
        }

    }
}
