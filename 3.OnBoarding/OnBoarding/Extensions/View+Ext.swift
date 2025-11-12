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
            .modifier(OnBoardingItemSetter(position: position, onBoardingContent: content))
    }
    
    func snapshotScreen() -> UIImage? {
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen {
            let snapshotView: UIView = screen.snapshotView(afterScreenUpdates: true)
            let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: snapshotView.bounds.size)
            let image: UIImage = renderer.image { context in
                snapshotView.drawHierarchy(in: snapshotView.bounds, afterScreenUpdates: true)
            }
            
            return image
        }
        
        return nil 
    }
}
