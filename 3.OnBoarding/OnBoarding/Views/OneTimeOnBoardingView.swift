//
//  OneTimeOnBoardingView.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

struct OneTimeOnBoardingView<Content: View>: View {
    @AppStorage var isOnBoarded: Bool
    var content: Content
    var beginOnBoarding: () async -> Void
    var onBoardingFinished: () -> Void
    var coordinator: OnBoardingCoordinator = .init()
    
    init(
        appStorageID: String,
        @ViewBuilder content: @escaping () -> Content,
        beginOnBoarding: @escaping () async -> Void,
        onBoardingFinished: @escaping () -> Void
    ) {
        self._isOnBoarded = .init(wrappedValue: false, appStorageID)
        self.content = content()
        self.beginOnBoarding = beginOnBoarding
        self.onBoardingFinished = onBoardingFinished
    }
    
    var body: some View {
        content
            .environment(coordinator)
            .task {
                await beginOnBoarding()
                await createWindow()
            }
    }
    
    private func createWindow() async {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           !isOnBoarded, coordinator.overlayWindow == nil {
            let window: UIWindow = UIWindow(windowScene: scene)
            window.backgroundColor = .red
            window.isHidden = false
            window.isUserInteractionEnabled = true
            
            coordinator.overlayWindow = window
            
            try? await Task.sleep(for: .seconds(0.1))
            
            if coordinator.items.isEmpty {
                hideWindow()
            } else {
                guard let snapshot = snapshotScreen() else {
                    hideWindow()
                    return
                }
                
                let hostController: UIHostingController = .init(rootView: OverlayWindowView(snapshot: snapshot).environment(coordinator))
                hostController.view.backgroundColor = .clear
                coordinator.overlayWindow?.rootViewController = hostController
            }
        }
    }
    
    private func hideWindow() {
        coordinator.overlayWindow?.isHidden = true
        coordinator.overlayWindow?.isUserInteractionEnabled = false
    }
}

