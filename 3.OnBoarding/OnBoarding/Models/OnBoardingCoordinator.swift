//
//  OnBoardingCoordinator.swift
//  OnBoarding
//
//  Created by 멘태 on 11/11/25.
//

import SwiftUI

@Observable
final class OnBoardingCoordinator {
    var items: [OnBoardingItem] = []
    var overlayWindow: UIWindow?
    
    var orderedItems: [OnBoardingItem] {
        return items.sorted { $0.id < $1.id }
    }
}
