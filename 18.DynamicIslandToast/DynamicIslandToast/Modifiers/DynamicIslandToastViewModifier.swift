//
//  DynamicIslandToastViewModifier.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

struct DynamicIslandToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var overlayWindow: PassThroughWindow?
    @State private var overlayController: CustomHostingView?
    
    var value: Toast
    
    func body(content: Content) -> some View {
        content
            .background {
                WindowExtractor { mainWindow in
                    createOverlayWindow(mainWindow)
                }
            }
    }
    
    private func createOverlayWindow(_ mainWindow: UIWindow) {
        guard let windowScene = mainWindow.windowScene else { return }
        let overlayWindow = PassThroughWindow(windowScene: windowScene)
        
        if let window = windowScene.windows.first(where: { $0.tag == 1009 }) as? PassThroughWindow {
            print("Window is already exisiting.")
            self.overlayWindow = window
        } else {
            overlayWindow.backgroundColor = .clear
            overlayWindow.isHidden = false
            overlayWindow.isUserInteractionEnabled = true
            createRootController(overlayWindow)
            self.overlayWindow = overlayWindow
        }
    }
    
    private func createRootController(_ window: PassThroughWindow) {
        let hostingController = CustomHostingView(rootView: ToastView())
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        self.overlayController = hostingController
    }
}

#Preview {
    ContentView()
}
