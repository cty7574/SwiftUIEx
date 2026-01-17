//
//  WindowExtractor.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

struct WindowExtractor: UIViewRepresentable {
    var result: (UIWindow) -> Void
    
    func makeUIView(context: Context) -> some UIView {
        let view: UIView = UIView(frame: .zero)
        
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let window = view.window {
                result(window)
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
