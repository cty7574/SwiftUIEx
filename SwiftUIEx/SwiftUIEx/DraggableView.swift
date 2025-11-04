//
//  DraggableView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/4/25.
//

import SwiftUI

struct DraggableView: View {
    @State private var selectedIDs: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(colorItems) { item in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(item.color)
                        .frame(width: 80, height: 80)
                        .overlay {
                            if selectedIDs.contains(item.id) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                            }
                        }
                        .onTapGesture {
                            if selectedIDs.contains(item.id) {
                                selectedIDs.removeAll { $0 == item.id }
                            } else {
                                selectedIDs.append(item.id)
                            }
                        }
                        .draggable(item.id)
                }
            }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(height: 150)
                .overlay {
                    Text("Drop Area")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .dropDestination(for: String.self) { items, session in
                    print("Dropped item: \(items)")
                    
                    for item in items {
                        selectedIDs.removeAll { $0 == item }
                    }
                }
        }
        .padding(20)
    }
}

struct ColorItem: Identifiable {
    var id: String = UUID().uuidString
    var color: Color
}

let colorItems: [ColorItem] = [
    ColorItem(color: .red),
    ColorItem(color: .orange),
    ColorItem(color: .yellow),
    ColorItem(color: .green),
    ColorItem(color: .blue),
    ColorItem(color: .indigo),
    ColorItem(color: .purple),
]

#Preview {
    DraggableView()
}
