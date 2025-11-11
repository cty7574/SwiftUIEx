//
//  OneTimeOnBoardingView.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

struct OneTimeOnBoardingView<Content: View>: View {
    @AppStorage var isOnBoarding: Bool
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
        self._isOnBoarding = .init(wrappedValue: false, appStorageID)
        self.content = content()
        self.beginOnBoarding = beginOnBoarding
        self.onBoardingFinished = onBoardingFinished
    }
    
    var body: some View {
        content
    }
}

