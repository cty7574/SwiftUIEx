//
//  Task.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/24/25.
//

import SwiftData
import SwiftUI

@Model
final class Task: Identifiable {
    var id: UUID
    var title: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: Color
    
    init(id: UUID = UUID(), title: String, creationDate: Date = Date(), isCompleted: Bool = false, tint: Color) {
        self.id = id
        self.title = title
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
}


