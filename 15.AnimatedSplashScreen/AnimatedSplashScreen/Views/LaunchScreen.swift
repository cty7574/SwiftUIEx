//
//  LaunchScreen.swift
//  AnimatedSplashScreen
//
//  Created by 멘태 on 1/2/26.
//

import SwiftUI

struct LaunchScreen<RootView: View, Logo: View>: Scene {
    @ViewBuilder var rootContent: RootView
    @ViewBuilder var logo: () -> Logo
    
    var body: some Scene {
        WindowGroup {
            rootContent
                .modifier(LaunchScreenModifier(logo: logo))
        }
    }
}

fileprivate struct LaunchScreenModifier<Logo: View>: ViewModifier {
    @ViewBuilder var logo: Logo
    @Environment(\.scenePhase) private var scenePhase
    @State private var splashWindow: UIWindow?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                let scenes = UIApplication.shared.connectedScenes
                
                for scene in scenes {
                    guard let windowScene = scene as? UIWindowScene,
                          checkStates(windowScene.activationState),
                          !windowScene.windows.contains(where: { $0.tag == 1009 })
                    else {
                        print("Already have a splash window for this scene")
                        continue
                    }
                    
                    let window = UIWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    
                    let rootViewController: UIHostingController = .init(rootView: LaunchScreenView {
                        logo
                    })
                    rootViewController.view.backgroundColor = .clear
                    window.rootViewController = rootViewController
                    
                    self.splashWindow = window
                    print("Splash Window Added")
                }
            }
    }
    
    private func checkStates(_ state: UIWindowScene.ActivationState) -> Bool {
        switch scenePhase {
        case .background: return state == .background
        case .inactive: return state == .foregroundInactive
        case .active: return state == .foregroundActive
        default: return state.hashValue == scenePhase.hashValue
        }
    }
}

fileprivate struct LaunchScreenView<Logo: View>: View {
    @ViewBuilder var logo: Logo
    
    var body: some View {
        
    }
}
