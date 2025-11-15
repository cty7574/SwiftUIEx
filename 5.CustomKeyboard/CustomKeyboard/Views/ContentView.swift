//
//  ContentView.swift
//  CustomKeyboard
//
//  Created by 멘태 on 11/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @FocusState private var isActive: Bool
    
    var body: some View {
        NavigationStack {
            CustomTextFieldWithKeyboard {
                TextField("App Pin Code", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 150)
                    .background(.fill, in: .rect(cornerRadius: 15))
            } keyboard: {
                CustomKeyboardView(text: $text, isActive: $isActive)
            }
            .navigationTitle("Custom Keyboard")

        }
    }
}

#Preview {
    ContentView()
}
