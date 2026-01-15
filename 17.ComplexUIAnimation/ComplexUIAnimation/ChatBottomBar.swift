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
    @GestureState private var isHolding: Bool = false
    @GestureState private var isRecording: Bool = false
    @GestureState private var recorderOffset: CGFloat = 0.0
    @State private var lastRecorderOffset: CGFloat = 0.0
    @State private var recorderStartTimeStamp: Date = .now
    @State private var disableBottomBar: Bool = false
    
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
        let recordingSymbol: String = isRecording ? "waveform" : "mic.fill"
        return message.isEmpty ? recordingSymbol : "paperplane.fill"
    }
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 6) {
                AnimatedMenuButton(
                    disableBottomBar: $disableBottomBar,
                    isRecording: isRecording,
                    action: addMenu
                )
                
                TextField(hint, text: $message)
                    .lineLimit(5)
                    .opacity(isRecording ? 0 : 1)
                    .overlay(alignment: .trailing) {
                        if isRecording {
                            HStack(spacing: 0) {
                                Text(recorderStartTimeStamp, style: .timer)
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray)
                                
                                Spacer()
                                
                                SlideToCancelText(text: "Slide to cancel")
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .animation(.interpolatingSpring(duration: 0.3), value: isRecording)
            }
            .padding(.horizontal, 12)
            .frame(height: 48)
            .background(.ultraThinMaterial, in: .capsule)
            .mask {
                Rectangle()
                    .padding(-50)
                    .padding(.trailing, abs(recorderOffset))
            }
            .shadow(radius: 1)
            
            Image(systemName: mainActionSymbol)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .contentTransition(.symbolEffect(.replace, options: .default.speed(1.2)))
                .frame(width: 48, height: 48)
                .background(.blue.gradient, in: .circle)
                .scaleEffect(isHolding ? 1.3 : 1)
                .offset(x: recorderOffset)
                .gesture(sendMessageGesture, isEnabled: !message.isEmpty)
                .gesture(
                    LongPressGesture(minimumDuration: 0.3, maximumDistance: 0)
                        .sequenced(before: DragGesture(minimumDistance: 10))
                        .updating($isHolding, body: { _, out, _ in
                            out = true
                        })
                        .updating($isRecording, body: { value, out, _ in
                            if case .second(_, _) = value {
                                out = true
                            } else {
                                out = false
                            }
                        })
                        .updating($recorderOffset, body: { value, out, _ in
                            if case let .second(_, gesture) = value, let gesture {
                                let translation = gesture.translation.width
                                let cappedOffset = max(min(translation, 0), -200)
                                out = cappedOffset
                            }
                        }),
                    isEnabled: message.isEmpty
                )
        }
        .animation(.interpolatingSpring(duration: 0.4), value: isHolding)
        .animation(.interactiveSpring(duration: 0.3), value: recorderOffset == 0)
        .onChange(of: isRecording) { oldValue, newValue in
            if newValue {
                recorderStartTimeStamp = .now
                onRecordingStart()
            } else {
                if -lastRecorderOffset > 50 {
                    onRecordingFinished(true)
                } else {
                    onRecordingFinished(false)
                }
                
                lastRecorderOffset = 0
            }
        }
        .onChange(of: recorderOffset) { oldValue, newValue in
            if isRecording {
                lastRecorderOffset = newValue
            }
        }
    }
}

#Preview {
    ContentView()
}
