//
//  CustomTextField.swift
//  LoginUI
//
//  Created by 멘태 on 12/11/25.
//

import SwiftUI

struct CustomTextField: View {
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    var isPassword: Bool = false
    
    @State private var showPassword: Bool = false
    @Binding var value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
                .frame(width: 30)
                .offset(y: 2)
            
            VStack(alignment: .leading) {
                if isPassword {
                    Group {
                        if showPassword {
                            TextField(hint, text: $value)
                        } else {
                            SecureField(hint, text: $value)
                        }
                    }
                } else {
                    TextField(hint, text: $value)
                }
                
                Divider()
            }
            .overlay(alignment: .trailing) {
                if isPassword {
                    Button {
                        withAnimation {
                            showPassword.toggle()
                        }
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    }
                }
            }
        }
    }
}
