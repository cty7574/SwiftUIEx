//
//  CustomButton.swift
//  ExpandableMenus
//
//  Created by 멘태 on 1/7/26.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var symbol: String
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                Spacer()
                Image(systemName: symbol)
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background, in: .capsule)
    }
}

#Preview {
    CustomButton(title: "title", symbol: "globe")
}
