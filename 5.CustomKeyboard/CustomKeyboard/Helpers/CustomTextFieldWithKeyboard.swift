//
//  CustomTextFieldWithKeyboard.swift
//  CustomKeyboard
//
//  Created by 멘태 on 11/15/25.
//

import SwiftUI

struct CustomTextFieldWithKeyboard<TextField: View, Keyboard: View>: UIViewControllerRepresentable {
    @ViewBuilder var textField: TextField
    @ViewBuilder var keyboard: Keyboard
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller: UIHostingController = .init(rootView: textField)
        controller.view.backgroundColor = .clear
        
        return controller
    }
        
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize,
                      uiViewController: UIViewControllerType,
                      context: Context) -> CGSize? {
        return uiViewController.view.intrinsicContentSize
    }
}

#Preview {
    ContentView()
}
