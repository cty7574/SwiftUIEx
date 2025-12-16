//
//  SignUpView.swift
//  LoginUI
//
//  Created by 멘태 on 12/12/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var emailID: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @Binding var showSignUp: Bool
    
    private var isFormValid: Bool {
        return !emailID.isEmpty && !fullName.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 26) {
                CustomTextField(sfIcon: "at", hint: "Email ID", value: $emailID)
                CustomTextField(sfIcon: "person", hint: "Full Name", value: $fullName)
                CustomTextField(sfIcon: "lock", hint: "password", isPassword: true, value: $password)
                
//                Button("Forgot Password?") {
//                    
//                }
//                .font(.callout)
//                .fontWeight(.heavy)
//                .tint(.yellow)
//                .hSpacing(.trailing)
                
                GradientButton(title: "Continue", icon: "arrow.right") {
                    
                }
                .hSpacing(.trailing)
                .disableWithOpacity(isFormValid)
            }
            .padding(.top, 20)
            
            Spacer()
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button("LogIn") {
                    showSignUp = false 
                }
                .fontWeight(.bold)
                .tint(.yellow)
            }
            .font(.callout)
            .hSpacing()
        }
        .padding(.vertical)
        .padding(.horizontal, 26)
    }
}

#Preview {
    SignUpView(showSignUp: .constant(true))
}
