//
//  ContentView.swift
//  ComplexUIAnimation
//
//  Created by 멘태 on 1/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .navigationTitle("iJustine")
            .safeAreaInset(edge: .bottom) {
                ChatBottomBar(message: $message) {
                    
                } onRecordingStart: {
                    
                } onRecordingFinished: { discarded in
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
        }
    }
}

#Preview {
    ContentView()
}
