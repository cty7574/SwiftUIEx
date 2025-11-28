//
//  Color+Ext.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/28/25.
//

import SwiftUI

extension Color {
    static var taskColorNames: [String] {
        return ["yellow", "cyan", "white", "pink", "gray"]
    }
    
    static func getTaskColor(for name: String) -> Color {
        switch name {
        case "yellow": return .yellow
        case "cyan": return .cyan
        case "white": return .white
        case "pink": return .pink
        case "gray": return .gray
        default: return .white
        }
    }
    
    func getTaskName() -> String {
        switch self {
        case .yellow: return "yellow"
        case .cyan: return "cyan"
        case .white: return "white"
        case .pink: return "pink"
        case .gray: return "gray"
        default: return "white"
        }
    }
}
