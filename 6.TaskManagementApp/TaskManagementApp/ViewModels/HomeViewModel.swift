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
        var tasks: [Task] = []
    }
}
