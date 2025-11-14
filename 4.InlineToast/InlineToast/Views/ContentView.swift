//
//  ContentView.swift
//  InlineToast
//
//  Created by 멘태 on 11/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showIncorrectToast: Bool = false
    @State private var showResetToast: Bool = false
    
    var body: some View {
        NavigationStack {
            let incorrectToastConfig: InlineToastConfig = .init(
                icon: "exclamationmark.circle.fill",
                title: "Incorrect password :(",
                subTitle: "Oops! That didn't match. Give it another shot.",
                tint: .red,
                anchor: .top,
                actionIcon: "xmark"
            ) {
                showIncorrectToast = false
            }
            
            let resetToastConfig: InlineToastConfig = .init(
                icon: "checkmark.circle.fill",
                title: "Password Reset Email Sent!",
                subTitle: "",
                tint: .green,
                anchor: .bottom,
                actionIcon: "xmark"
            ) {
                showResetToast = false
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Email Address")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("", text: .constant(""))
                
                Text("Password")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                SecureField("", text: .constant(""))
                
                VStack(alignment: .trailing, spacing: 20) {
                    Button {
                        showIncorrectToast.toggle()
                    } label: {
                        Text("Login in to Account")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 2)
                    }
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .inlineToast(config: incorrectToastConfig, isPresented: showIncorrectToast)
                    
                    Button("Forgot Password?") {
                        showResetToast.toggle()
                    }
                    .inlineToast(config: resetToastConfig, isPresented: showResetToast)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            .navigationTitle("Login")
            .animation(.smooth(duration: 0.35, extraBounce: 0), value: showResetToast)
            .animation(.smooth(duration: 0.35, extraBounce: 0), value: showIncorrectToast)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
