//
//  OTPView.swift
//  LoginUI
//
//  Created by 멘태 on 12/16/25.
//

import SwiftUI

struct OTPView: View {
    @Binding var otpText: String
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        return !otpText.isEmpty && otpText.count == 6
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 15)
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("An 6 digit code has been sent to your Email ID.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 26) {
                OTPVerificationView(otpText: $otpText)
                
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    dismiss()
                    
                }
                .hSpacing(.trailing)
                .disableWithOpacity(isFormValid)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding(.vertical)
        .padding(.horizontal, 26)
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
