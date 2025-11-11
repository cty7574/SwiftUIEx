//
//  View+Ext.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func onBoarding<Content: View>(_ position: Int, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            
    }
}
