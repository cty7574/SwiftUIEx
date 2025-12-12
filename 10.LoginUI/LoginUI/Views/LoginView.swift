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
    @Binding var showSignUp: Bool
    
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
                    
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.yellow)
                .hSpacing(.trailing)
                
                GradientButton(title: "Login", icon: "arrow.right") {
                    
                }
                .hSpacing(.trailing)
                .opacity((emailID.isEmpty || password.isEmpty) ? 0.5 : 1)
                .disabled(emailID.isEmpty || password.isEmpty)
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
    }
}

#Preview {
    ContentView()
}
