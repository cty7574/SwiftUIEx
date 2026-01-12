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
                    print("Send Message")
                } onRecordingStart: {
                    print("Start Recording")
                } onRecordingFinished: { discarded in
                    if discarded {
                        print("Discard Recording")
                    } else {
                        print("Send Recording")
                    }
                } addMenu: {
                    print("Open Menu")
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
