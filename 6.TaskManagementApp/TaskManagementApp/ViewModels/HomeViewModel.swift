//
//  HomeViewModel.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/25/25.
//

import SwiftUI
import Observation

extension HomeView {
    @Observable
    final class ViewModel {
        var tasks: [Task] = [
            Task(title: "Record Video", creationDate: .updateHour(-5), isCompleted: true, tint: .yellow),
            Task(title: "Redesign Website", creationDate: .updateHour(-3), tint: .blue),
            Task(title: "Go for a Walk", creationDate: .updateHour(-4), tint: .white),
            Task(title: "Edit Video", creationDate: .updateHour(0), isCompleted: true, tint: .brown),
            Task(title: "Publish Video", creationDate: .updateHour(2), isCompleted: true, tint: .yellow),
            Task(title: "Tweet about new Video", creationDate: .updateHour(1), tint: .pink)
        ]
    }
}
