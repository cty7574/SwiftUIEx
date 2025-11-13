//
//  OverlayWindowView.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

struct OverlayWindowView: View {
    var snapshot: UIImage
    @Environment(OnBoardingCoordinator.self) var coordinator
    @State private var animate: Bool = false
    @State private var currentIndex: Int = 0
    
    private var orderedItems: [OnBoardingItem] {
        return coordinator.orderedItems
    }
    
    var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets
            let isHomeButtoniPhone: Bool = safeArea.bottom == 0
            let cornerRadius: CGFloat = isHomeButtoniPhone ? 15 : 35
            
            ZStack {
                Rectangle()
                    .fill(.black)
                
                Image(uiImage: snapshot)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .reverseMask(alignment: .topLeading) {
                                if !orderedItems.isEmpty {
                                    let maskLocation = orderedItems[currentIndex].maskLocation
                                    
                                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                                        .frame(width: maskLocation.width, height: maskLocation.height)
                                        .offset(x: maskLocation.minX, y: maskLocation.minY)
                                }
                            }
                            .opacity(animate ? 1 : 0)
                    }
                    .clipShape(.rect(cornerRadius: animate ? cornerRadius : 0, style: .circular))
                    .overlay {
                        iPhoneShape(safeArea)
                    }
                    .scaleEffect(animate ? 0.65 : 1, anchor: .top)
                    .offset(y: animate ? safeArea.top + 25 : 0)
                    .background(alignment: .bottom) {
                        bottomView(safeArea)
                    }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            guard !animate else { return }
            
            withAnimation(.smooth(duration: 0.35, extraBounce: 0)) {
                animate = true
            }
        }
    }
    
    @ViewBuilder
    private func iPhoneShape(_ safeArea: EdgeInsets) -> some View {
        let isHomeButtoniPhone: Bool = safeArea.bottom == 0
        let cornerRadius: CGFloat = isHomeButtoniPhone ? 20: 45
        
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: animate ? cornerRadius : 0, style: .continuous)
                .stroke(.white, lineWidth: animate ? 15 : 0)
                .padding(-6)
            
            if safeArea.bottom != 0 {
                Capsule()
                    .fill(.black)
                    .frame(width: 120, height: 40)
                    .offset(y: 20)
                    .opacity(animate ? 1 : 0)
            }
        }
    }
    
    @ViewBuilder
    private func bottomView(_ safeArea: EdgeInsets) -> some View {
        VStack(spacing: 10) {
            ZStack {
                ForEach(orderedItems) { info in
                    if currentIndex == orderedItems.firstIndex(where: { $0.id == info.id }) {
                        info.view
                            .transition(.blurReplace)
                            .environment(\.colorScheme, .dark)
                    }
                }
            }
            .frame(height: 70)
            .frame(maxWidth: 280)
            
            HStack(spacing: 6) {
                if currentIndex > 0 {
                    Button {
                        withAnimation(.smooth(duration: 0.35, extraBounce: 0)) {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 38))
                            .foregroundStyle(.white, .gray.opacity(0.4))
                    }

                }
                
                Button {
                    if currentIndex == orderedItems.count - 1 {
                        closeWindow()
                    } else {
                        withAnimation(.smooth(duration: 0.35, extraBounce: 0)) {
                            currentIndex += 1
                        }
                    }
                } label: {
                    Text(currentIndex == orderedItems.count - 1 ? "Finish" : "Next")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .contentTransition(.numericText())
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .background(.blue.gradient, in: .capsule)
                }
            }
            .frame(maxWidth: 250)
            .frame(height: 50)
            .padding(.leading, currentIndex > 0 ? -45 : 0)
            
            Button(action: closeWindow) {
                Text("Skip Tutorial")
                    .font(.callout)
                    .underline()
            }
            .foregroundStyle(.gray)

        }
        .padding(.horizontal)
        .padding(.bottom, safeArea.bottom + 10)
    }
    
    private func closeWindow() {
        withAnimation(.easeInOut(duration: 0.35), completionCriteria: .removed) {
            animate = false
        } completion: {
            coordinator.isOnBoardingFinished = true
        }
    }
}

#Preview {
    ContentView()
}
