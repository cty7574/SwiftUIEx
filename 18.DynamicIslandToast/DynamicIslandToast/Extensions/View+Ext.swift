//
//  View+Ext.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func dynamicIslandToast(isPresented: Binding<Bool>, value: Toast) -> some View {
        self
            .modifier(
                DynamicIslandToastViewModifier(
                    isPresented: isPresented,
                    value: value
                )
            )
    }
}
