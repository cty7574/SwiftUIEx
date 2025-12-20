//
//  ContentView.swift
//  CustomAsyncButton
//
//  Created by 멘태 on 12/19/25.
//

import SwiftUI

enum TransactionState: String {
    case idle = "Click to pay"
    case analyzing = "Analyzing Transaction"
    case processing = "Processing Transaction"
    case completed = "Transaction Completed"
    case failed = "Transaction Failed"
    
    var color: Color {
        switch self {
        case .idle: return .black
        case .analyzing: return .blue
        case .processing: return .orange
        case .completed: return .green
        case .failed: return .red
        }
    }
    
    var image: String? {
        switch self {
        case .idle: return "apple.logo"
        case .analyzing: return nil
        case .processing: return nil
        case .completed: return "checkmark.circle.fill"
        case .failed: return "xmark.circle.fill"
        }
    }
}

struct ContentView: View {
    @State private var transactionState: TransactionState = .idle
    
    var body: some View {
        NavigationStack {
            VStack {
                let config: AnimatedButton.Config = AnimatedButton.Config(
                    title: transactionState.rawValue,
                    foregroundColor: .white,
                    background: transactionState.color,
                    symbolImage: transactionState.image
                )
                
                AnimatedButton(config: config) {
                    transactionState = .analyzing
                    try? await Task.sleep(for: .seconds(3))
                    transactionState = .processing
                    try? await Task.sleep(for: .seconds(3))
                    transactionState = .failed
                    try? await Task.sleep(for: .seconds(1))
                    transactionState = .idle
                }
            }
            .navigationTitle("Custom Button")
        }
    }
}

#Preview {
    ContentView()
}
