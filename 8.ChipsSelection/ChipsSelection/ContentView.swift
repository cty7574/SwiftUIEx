//
//  ContentView.swift
//  ChipsSelection
//
//  Created by 멘태 on 12/3/25.
//

import SwiftUI

struct ContentView: View {
    private var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                ChipsView(tags: viewModel.tags) { tag, isSelected in
                    chipView(tag, isSelected: isSelected)
                } didChangeSelection: { selection in
                    print(selection)
                }
                .padding(10)
                .background(.gray.opacity(0.1), in: .rect(cornerRadius: 20))
            }
            .padding()
            .navigationTitle("Chips Selection")
        }
    }
    
    @ViewBuilder
    func chipView(_ tag: String, isSelected: Bool) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .foregroundStyle(isSelected ? .white : .primary)
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background {
            ZStack {
                Capsule()
                    .fill(.background)
                    .opacity(!isSelected ? 1 : 0)
                
                Capsule()
                    .fill(.green.gradient)
                    .opacity(isSelected ? 1 : 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
