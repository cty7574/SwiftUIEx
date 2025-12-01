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
                        Text(chip.name)
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(.red.gradient, in: .capsule)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
