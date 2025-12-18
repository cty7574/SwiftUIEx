//
//  ExtractImageViewsFromTabView.swift
//  AnimatedTabBar
//
//  Created by 멘태 on 12/17/25.
//

import SwiftUI

struct ExtractImageViewsFromTabView<Value: AnimatedTabSelectionProtocol>: UIViewRepresentable {
    var result: ([Value: UIImageView]) -> ()
    
    func makeUIView(context: Context) -> some UIView {
        let view: UIView = UIView()
        view.backgroundColor = .red
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            if let compositingGroup = view.superview?.superview {
                guard let tabHostingController = compositingGroup.subviews.last else { return }
                guard let tabController = tabHostingController.subviews.first?.next as? UITabBarController else { return }
                
                extractImageViews(tabController.tabBar)
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    private func extractImageViews(_ tabBar: UITabBar) {
        let imageViews = tabBar.subviews(type: UIImageView.self)
            .filter { $0.image?.isSymbolImage ?? false }
            .filter { isIOS26 ? ($0.tintColor == tabBar.tintColor) : true }
        
        var dict: [Value: UIImageView] = [:]
        
        for tab in Value.allCases {
            if let imageView = imageViews.first(where: { $0.description.contains(tab.symbolImage) }) {
                dict[tab] = imageView
            }
        }
        
        result(dict)
    }
    
    private var isIOS26: Bool {
        if #available(iOS 26, *) {
            return true
        }
        
        return false
    }
    
}
