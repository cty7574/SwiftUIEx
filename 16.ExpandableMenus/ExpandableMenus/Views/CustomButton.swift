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
    
    @Binding var isPresented: Bool
    
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
        .opacity(isPresented ? 1 : 0)
        .background {
            ZStack {
                Rectangle()
                    .fill(.primary)
                    .opacity(isPresented ? 0 : 1)
                
                Rectangle()
                    .fill(.background)
                    .opacity(isPresented ? 1 : 0)
            }
            .clipShape(.capsule)
        }
    }
}

#Preview {
    CustomButton(title: "title", symbol: "globe", isPresented: .constant(false))
}
