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
            .onChange(of: isPresented) { oldValue, newValue in
                guard let overlayWindow else { return }
                
                if newValue {
                    overlayWindow.toast = value
                }
                
                overlayWindow.isPresented = newValue
                overlayController?.isStatusBarHidden = newValue
            }
            .onChange(of: overlayWindow?.isPresented) { oldValue, newValue in
                if let newValue, let overlayWindow,
                   overlayWindow.toast?.id == value.id, newValue != isPresented {
                    isPresented = false 
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
            overlayWindow.tag = 1009
            createRootController(overlayWindow)
            
            self.overlayWindow = overlayWindow
        }
    }
    
    private func createRootController(_ window: PassThroughWindow) {
        let hostingController = CustomHostingView(rootView: ToastView(window: window))
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        
        self.overlayController = hostingController
    }
}

#Preview {
    ContentView()
}
