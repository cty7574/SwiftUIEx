//
//  PasswordResetView.swift
//  LoginUI
//
//  Created by 멘태 on 12/15/25.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        return !password.isEmpty && !confirmPassword.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)
            
            Text("Reset Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            VStack(spacing: 26) {
                CustomTextField(sfIcon: "lock", hint: "Password", value: $password)
                CustomTextField(sfIcon: "lock", hint: "Confirm Password", value: $confirmPassword)
                
                
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    dismiss()
                    
                }
                .hSpacing(.trailing)
                .opacity(isFormValid ? 1 : 0.5)
                .disabled(!isFormValid)
            }
            .padding(.top, 20)
        }
        .padding(.vertical)
        .padding(.horizontal, 26)
        .interactiveDismissDisabled()
    }
}

#Preview {
    PasswordResetView()
}
