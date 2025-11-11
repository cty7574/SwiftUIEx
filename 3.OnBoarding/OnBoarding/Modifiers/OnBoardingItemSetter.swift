//
//  OnBoardingItemSetter.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

struct OnBoardingItemSetter<OnBoardingContent: View>: ViewModifier {
    var position: Int
    @ViewBuilder var onBoardingContent: OnBoardingContent
    
    @Environment(OnBoardingCoordinator.self) var coordinater
    
    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: CGRect.self) { proxy in
                proxy.frame(in: .global)
            } action: { newValue in
                coordinater.items.removeAll { $0.id == position }
                
                let newItem: OnBoardingItem = .init(
                    id: position,
                    view: .init(onBoardingContent),
                    maskLocation: newValue
                )
                
                coordinater.items.append(newItem)
            }

    }
}
