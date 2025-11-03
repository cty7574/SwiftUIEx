//
//  ToolbarSpacerView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI

struct ToolbarSpacerView: View {
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Todo's")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("", systemImage: "suit.heart.fill") {
                            
                        }
                        
                        Button("", systemImage: "magnifyingglass") {
                            
                        }
                    }
                }
                
                // 툴바를 분리할 때 사용
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "person.fill") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ToolbarSpacerView()
}
