//
//  TaskRowView.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/25/25.
//

import SwiftData
import SwiftUI

struct TaskRowView: View {
    @Bindable var task: Task
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10, alignment: .center)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .contentShape(.circle)
                        .blendMode(.destinationOver)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                task.isCompleted.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Label(task.creationDate.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            .padding()
            .hSpacing(.leading)
            .background(Color.getTaskColor(for: task.tint), in: .rect(topLeadingRadius: 16, bottomLeadingRadius: 16))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            //.contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    context.delete(task)
                    try? context.save()
                }
            }
            .offset(y: -8)
        }
    }
    
    var indicatorColor: Color {
        if task.isCompleted { return .green }
        
        return task.creationDate.isSameHour
        ? .blue
        : (task.creationDate.isPast
           ? .red
           : .black)
    }
}

#Preview {
    ContentView()
}
