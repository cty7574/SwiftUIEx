//
//  ContentView.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OneTimeOnBoardingView(appStorageID: "Home_Tutorial") {
            VStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
                .onBoarding(1) {
                    
                }
                
                Button("Download") {
                    
                }
                .padding()
                .onBoarding(2) {
                    
                }
            }
        } beginOnBoarding: {
            
        } onBoardingFinished: {
            
        }

    }
}

#Preview {
    ContentView()
}
