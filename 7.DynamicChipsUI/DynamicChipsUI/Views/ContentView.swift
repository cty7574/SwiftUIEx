//
//  ContentView.swift
//  DynamicChipsUI
//
//  Created by 멘태 on 12/1/25.
//

import SwiftUI

struct ContentView: View {
    private var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                ChipsView {
                    ForEach(viewModel.chips) { chip in
                        let viewWidth = chip.name.size(.preferredFont(forTextStyle: .body)).width + 20
                        
                        Text(chip.name)
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(.red.gradient, in: .capsule)
                            .containerValue(\.viewWidth, viewWidth)
                    }
                }
                .frame(width: 300)
                .padding()
                .background(.primary.opacity(0.06), in: .rect(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    ContentView()
}
