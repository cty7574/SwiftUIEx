//
//  CustomList.swift
//  StickyHeaderList
//
//  Created by 멘태 on 11/7/25.
//

import SwiftUI

struct CustomList<NavBar: View, TopContent: View, Header: View, Content: View>: View {
    @ViewBuilder var navBar: (_ progress: CGFloat) -> NavBar
    @ViewBuilder var topContent: (_ progress: CGFloat, _ safeAreaTop: CGFloat) -> TopContent
    @ViewBuilder var header: (_ progress: CGFloat) -> Header
    @ViewBuilder var content: Content
    
    @State private var headerProgress: CGFloat = 0
    @State private var safeAreaTop: CGFloat = 0
    
    var body: some View {
        List {
            topContent(headerProgress, safeAreaTop)
            
            Section {
                content
            } header: {
                header(headerProgress)
            }
        }
        .listRowSpacing(0)
        .listRowSpacing(0)
        .coordinateSpace(.named("LISTVIEW"))
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.safeAreaInsets.top
        } action: { newValue in
            safeAreaTop = newValue
        }

    }
}
