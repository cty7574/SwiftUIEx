//
//  LaunchScreen.swift
//  AnimatedSplashScreen
//
//  Created by 멘태 on 1/2/26.
//

import SwiftUI

struct LaunchScreen<RootView: View, Logo: View>: Scene {
    var config: LaunchScreenConfig = .init()
    
    @ViewBuilder var rootContent: RootView
    @ViewBuilder var logo: () -> Logo
    
    var body: some Scene {
        WindowGroup {
            rootContent
                .modifier(LaunchScreenModifier(config: config, logo: logo))
        }
    }
}

fileprivate struct LaunchScreenModifier<Logo: View>: ViewModifier {
    var config: LaunchScreenConfig
    @State private var splashWindow: UIWindow?
    
    @ViewBuilder var logo: Logo
    @Environment(\.scenePhase) private var scenePhase
    
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
                    
                    let rootViewController: UIHostingController = .init(rootView: LaunchScreenView(config: config) {
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

struct LaunchScreenConfig {
    var initialDelay: Double = 0.35
    var backgroundColor: Color = .black
    var logoBackgroundColor: Color = .white
    var scaling: CGFloat = 4
    var forceHideLogo: Bool = false
    var animationDuration: CGFloat = 1
}

fileprivate struct LaunchScreenView<Logo: View>: View {
    var config: LaunchScreenConfig
    @ViewBuilder var logo: Logo
     
    var body: some View {
        Rectangle()
            .fill(config.backgroundColor)
            .mask {
                Rectangle()
                    .overlay {
                        logo
                            .blendMode(.destinationOut)
                    }
            }
            .background {
                Rectangle()
                    .fill(config.logoBackgroundColor)
            }
            .ignoresSafeArea()
    }
}
