//
//  ContentView.swift
//  LoginUI
//
//  Created by 멘태 on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSignUp: Bool = false
    
    var body: some View {
        NavigationStack {
            LoginView(showSignUp: $showSignUp)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView(showSignUp: $showSignUp)
                }
        }
        .overlay {
            if #available(iOS 17, *) {
                circleView()
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignUp)
            } else {
                circleView()
                    .animation(.easeInOut(duration: 0.3), value: showSignUp)
            }
        }
    }
    
    @ViewBuilder
    func circleView() -> some View {
        Circle()
            .fill(.yellow.gradient)
            .frame(width: 200, height: 200)
            .offset(x: showSignUp ? 90 : -90, y: -90)
            .blur(radius: 15)
            .hSpacing(showSignUp ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    ContentView()
}
