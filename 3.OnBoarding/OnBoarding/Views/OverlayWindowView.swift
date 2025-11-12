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
                    .clipShape(.rect(cornerRadius: animate ? cornerRadius : 0, style: .circular))
                    .overlay {
                        iPhoneShape(safeArea)
                    }
                    .scaleEffect(animate ? 0.65 : 1, anchor: .top)
                    .offset(y: animate ? safeArea.top + 25 : 0)
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
}

#Preview {
    ContentView()
}
