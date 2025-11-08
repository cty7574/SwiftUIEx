//
//  ViewModel.swift
//  StickyHeaderList
//
//  Created by 멘태 on 11/8/25.
//

import SwiftUI
import Combine

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var menuCards: [MenuCard] = [
            .init(title: "Order Again"),
            .init(title: "Picked For You"),
            .init(title: "Starters"),
            .init(title: "French")
        ]
    }
}
