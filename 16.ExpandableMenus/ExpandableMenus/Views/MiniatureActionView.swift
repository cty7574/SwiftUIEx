//
//  MiniatureAction.swift
//  ExpandableMenus
//
//  Created by 멘태 on 1/7/26.
//

import SwiftUI

struct MiniatureActionView<Actions: View, Background: View>: View {
    var innerScaling: CGFloat = 1
    var minimisedButtonSize: CGSize = .init(width: 50, height: 50)
    var animation: Animation
    
    @Binding var isPresented: Bool 
    
    @ViewBuilder var actions: Actions
    @ViewBuilder var background: Background
    
    var body: some View {
        actions
            .compositingGroup()
    }
}

#Preview {
    ContentView()
}
