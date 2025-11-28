//
//  TasksView.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/27/25.
//

import SwiftData
import SwiftUI

struct TasksView: View {
    @Binding var currentDate: Date
    @Query private var tasks: [Task]
    
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        
        let calendar: Calendar = .current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Task> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        
        let sortDescriptor = [SortDescriptor(\Task.creationDate, order: .forward)]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 36) {
            ForEach(tasks) { task in
                TaskRowView(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -36)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 16)
        .padding(.top, 16)
        .overlay {
            if tasks.isEmpty {
                Text("No Task's Found")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 150)
            }
        }
    }
}

