//
//  LoginView.swift
//  LoginUI
//
//  Created by 멘태 on 12/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var showForgotPassword: Bool = false
    @State private var showResetView: Bool = false
    @Binding var showSignUp: Bool
    
    private var isFormValid: Bool {
        return !emailID.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 26) {
                CustomTextField(sfIcon: "at", hint: "Email ID", value: $emailID)
                CustomTextField(sfIcon: "lock", hint: "password", isPassword: true, value: $password)
                
                Button("Forgot Password?") {
                    showForgotPassword.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.yellow)
                .hSpacing(.trailing)
                
                GradientButton(title: "Login", icon: "arrow.right") {
                    
                }
                .hSpacing(.trailing)
                .opacity(isFormValid ? 1 : 0.5)
                .disabled(isFormValid)
            }
            .padding(.top, 20)
            
            Spacer()
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("SignUp") {
                    showSignUp.toggle()
                }
                .fontWeight(.bold)
                .tint(.yellow)
            }
            .font(.callout)
            .hSpacing()
        }
        .padding(.vertical)
        .padding(.horizontal, 26)
        .sheet(isPresented: $showForgotPassword) {
            if #available(iOS 16.4, *) {
                ForgotPasswordView(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPasswordView(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
            }
        }
        .sheet(isPresented: $showResetView) {
            if #available(iOS 16.4, *) {
                PasswordResetView()
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            } else {
                PasswordResetView()
                    .presentationDetents([.height(350)])
            }
            
        }
    }
}

#Preview {
    ContentView()
}
