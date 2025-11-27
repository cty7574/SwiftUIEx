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
    var tint: String
    
    init(id: UUID = UUID(), title: String, creationDate: Date = Date(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.title = title
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "yellow": return .yellow
        case "cyan": return .cyan
        case "white": return .white
        case "pink": return .pink
        case "gray": return .gray
        default: return .white
        }
    }
}


