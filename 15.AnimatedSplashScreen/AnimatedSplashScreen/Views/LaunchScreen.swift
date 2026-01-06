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
                    } isCompleted: {
                        window.isHidden = true
                        window.isUserInteractionEnabled = false
                    })
                    window.tag = 1009
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
    var animation: Animation = .smooth(duration: 1, extraBounce: 1)
}

fileprivate struct LaunchScreenView<Logo: View>: View {
    var config: LaunchScreenConfig
    @ViewBuilder var logo: Logo
    @State private var scaleDown: Bool = false
    @State private var scaleUp: Bool = false
    var isCompleted: () -> Void
     
    var body: some View {
        Rectangle()
            .fill(config.backgroundColor)
            .mask {
                GeometryReader { proxy in
                    let size = proxy.size.applying(.init(scaleX: config.scaling, y: config.scaling))
                    
                    Rectangle()
                        .overlay {
                            logo
                                .blur(radius: config.forceHideLogo ? 0 : (scaleUp ? 15 : 0))
                                .blendMode(.destinationOut)
                                .animation(.smooth(duration: 0.3, extraBounce: 0)) { content in
                                    content
                                        .scaleEffect(scaleDown ? 0.8 : 1)
                                }
                                .visualEffect { [scaleUp] content, proxy in
                                    let scaleX: CGFloat = size.width / proxy.size.width
                                    let scaleY: CGFloat = size.height / proxy.size.height
                                    let maxScale = Swift.max(scaleX, scaleY)
                                    
                                    return content
                                        .scaleEffect(scaleUp ? maxScale : 1)
                                }
                        }
                }
            }
            .opacity(config.forceHideLogo ? 1 : (scaleUp ? 0 : 1))
            .background {
                Rectangle()
                    .fill(config.logoBackgroundColor)
                    .opacity(scaleUp ? 0 : 1)
            }
            .ignoresSafeArea()
            .task {
                guard !scaleDown else { return }
                
                try? await Task.sleep(for: .seconds(config.initialDelay))
                scaleDown = true
                
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(config.animation, completionCriteria: .logicallyComplete) {
                    scaleUp = true
                } completion: {
                    isCompleted()
                }
            }
    }
}
