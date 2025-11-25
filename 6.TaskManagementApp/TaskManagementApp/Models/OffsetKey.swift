//
//  OffsetKey.swift
//  TaskManagementApp
//
//  Created by 멘태 on 11/25/25.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
