//
//  Task.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/24/25.
//

import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var title: String
    var creationDate: Date = .init()
    var isCompleted: Bool = false
    var tint: Color
}

var samples: [Task] = [
    Task(title: "Record Video", creationDate: .updateHour(-5), isCompleted: true, tint: .blue),
    Task(title: "Redesign Website", creationDate: .updateHour(-3), tint: .blue),
    Task(title: "Go for a Walk", creationDate: .updateHour(-4), tint: .blue),
    Task(title: "Edit Video", creationDate: .updateHour(0), isCompleted: true, tint: .blue),
    Task(title: "Publish Video", creationDate: .updateHour(2), isCompleted: true, tint: .blue),
    Task(title: "Tweet about new Video", creationDate: .updateHour(1), tint: .blue)
]


