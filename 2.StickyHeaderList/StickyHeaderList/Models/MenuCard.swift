//
//  MenuCard.swift
//  StickyHeaderList
//
//  Created by 멘태 on 11/8/25.
//

import Foundation

struct MenuCard: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var items: [MenuItem] = (1...5).compactMap { _ in .init() }
}
