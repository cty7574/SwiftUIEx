//
//  GradientButton.swift
//  LoginUI
//
//  Created by 멘태 on 12/11/25.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    
    var body: some View {
        Button(action: onClick) {
            HStack {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 36)
            .background(.yellow.gradient, in: .capsule)
        }
    }
}

#Preview {
    ContentView()
}
