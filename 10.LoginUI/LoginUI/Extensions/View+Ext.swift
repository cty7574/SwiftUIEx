//
//  View+Ext.swift
//  LoginUI
//
//  Created by 멘태 on 12/11/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(!condition)
            .opacity(!condition ? 0.6 : 1)
    }
}
