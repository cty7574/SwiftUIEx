//
//  TempView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI
import FoundationModels

struct FoundationModelsView: View {
    @State private var prompt: String = ""
    @State private var answer: String = ""
    @State private var disableControls: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(answer)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            .safeAreaBar(edge: .bottom) {
                HStack {
                    TextField("prompt", text: $prompt)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .glassEffect(.regular, in: .capsule)
                    
                    Button {
                        Task {
                            guard !prompt.isEmpty else { return }
                            
                            do {
                                let session: LanguageModelSession = LanguageModelSession()
                                disableControls = true
                                
                                // --- UI 반영이 너무 느림 ---
                                //let answer = try await session.respond(to: prompt)
                                //self.answer = answer.content
                                
                                let response = session.streamResponse(to: prompt)
                                
                                for try await chunk in response {
                                    self.answer = chunk.content
                                }
                                
                                disableControls = false
                                prompt = ""
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.glass)
                    
                }
                .disabled(disableControls)
                .padding()
            }
        }
    }
}

#Preview {
    FoundationModelsView()
}
