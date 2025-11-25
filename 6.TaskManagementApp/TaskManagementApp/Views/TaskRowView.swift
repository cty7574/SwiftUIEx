//
//  TaskRowView.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/25/25.
//

import SwiftUI

struct TaskRowView: View {
    var task: Task
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(.blue)
                .frame(width: 10, height: 10, alignment: .center)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
            
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
            .background(task.tint, in: .rect(topLeadingRadius: 16, bottomLeadingRadius: 16))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .offset(y: -8)
        }
    }
}

#Preview {
    ContentView()
}
