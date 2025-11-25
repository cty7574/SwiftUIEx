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


