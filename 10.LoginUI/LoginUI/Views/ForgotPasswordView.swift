//
//  ForgotPasswordView.swift
//  LoginUI
//
//  Created by 멘태 on 12/13/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var emailID: String = ""
    @Binding var showResetView: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 10)
            
            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("Please enter your Email ID so that we can send the reset link.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 26) {
                CustomTextField(sfIcon: "at", hint: "Email ID", value: $emailID)
                
                
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    dismiss()
                }
                .hSpacing(.trailing)
                .opacity(!emailID.isEmpty ? 1 : 0.5)
                .disabled(emailID.isEmpty)
            }
            .padding(.top, 20)
        }
        .padding(.vertical)
        .padding(.horizontal, 26)
        .interactiveDismissDisabled()
    }
}

#Preview {
    ForgotPasswordView(showResetView: .constant(false))
}
