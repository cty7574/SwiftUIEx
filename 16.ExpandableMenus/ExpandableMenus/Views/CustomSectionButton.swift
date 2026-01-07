//
//  CustomSectionButton.swift
//  ExpandableMenus
//
//  Created by 멘태 on 1/7/26.
//

import SwiftUI

struct CustomSectionButton: View {
    var symbol: String
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background, in: .capsule)
        }
    }
}
