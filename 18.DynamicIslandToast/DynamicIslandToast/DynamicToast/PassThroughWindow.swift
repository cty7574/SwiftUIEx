//
//  PassThroughWindow.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

@Observable
final class PassThroughWindow: UIWindow {
    var toast: Toast?
    var isPresented: Bool = false
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view else {
            return nil
        }
        
        if #available(iOS 26, *) {
            if rootView.layer.hitTest(point)?.name == nil { return rootView }
            else { return nil }
        } else {
            if #unavailable(iOS 18) {
                return hitView == rootView ? nil : hitView
            } else {
                for subview in rootView.subviews.reversed() {
                    let pointInSubView = subview.convert(point, from: rootView)
                    
                    if subview.hitTest(pointInSubView, with: event) != nil { return hitView }
                }
                
                return nil 
            }
        }
        
    }
}
