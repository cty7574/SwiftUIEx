//
//  ChatBottomBar.swift
//  ComplexUIAnimation
//
//  Created by 멘태 on 1/10/26.
//

import SwiftUI

struct ChatBottomBar: View {
    var hint: String = "Type your message..."
    @Binding var message: String
    
    var sendMessage: () -> Void
    var onRecordingStart: () -> Void
    var onRecordingFinished: (_ discarded: Bool) -> Void
    var addMenu: () -> Void = {}
    
    var sendMessageGesture: some Gesture {
        TapGesture(count: 1).onEnded { _ in
            sendMessage()
        }
    }
    
    var mainActionSymbol: String {
        message.isEmpty ? "mic.fill" : "paperplane.fill"
    }
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 6) {
                Button(action: addMenu) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.primary)
                        .frame(width: 30)
                }
                
                TextField(hint, text: $message)
                    .lineLimit(5)
            }
            .padding(.horizontal, 12)
            .frame(height: 48)
            .background(.ultraThinMaterial, in: .capsule)
            
            Image(systemName: mainActionSymbol)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .contentTransition(.symbolEffect(.replace, options: .default))
                .frame(width: 48, height: 48)
                .background(.blue.gradient, in: .circle)
                .gesture(sendMessageGesture, isEnabled: !message.isEmpty)
        }
    }
}

#Preview {
    ContentView()
}
