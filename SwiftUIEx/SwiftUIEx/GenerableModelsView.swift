//
//  GenerableModelsView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI
import FoundationModels

struct GenerableModelsView: View {
    @State private var todos: [Todo] = []
    @State private var isWriting: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    Text(todo.task)
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "apple.intelligence") {
                        let prompt: String = "Create 10 todo list items."
                        
                        Task {
                            do {
                                let session = LanguageModelSession()
                                
                                let response = session.streamResponse(generating: [Todo].self) {
                                    prompt
                                }
                                
                                isWriting = true
                                
                                for try await chunk in response {
                                    self.todos = chunk.content.compactMap {
                                        if let id = $0.id, let task = $0.task {
                                            return .init(id: id, task: task)
                                        }
                                        
                                        return nil
                                    }
                                }
                                
                                isWriting = false
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            .scrollEdgeEffectStyle(.hard, for: .top) // default: Progressive Blur, 간단한 수정자로 이펙트 변경 가능
        }
    }
}

@Generable
struct Todo: Identifiable {
    var id: String
    
    @Guide(description: "") // 모델이 프로퍼티를 채울 때 필요한 문맥 제공
    var task: String
}

#Preview {
    GenerableModelsView()
}
