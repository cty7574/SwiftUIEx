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
    
    var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets
            
            ZStack {
                Rectangle()
                    .fill(.black)
                
                Image(uiImage: snapshot)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .ignoresSafeArea()
        }
    }
}
