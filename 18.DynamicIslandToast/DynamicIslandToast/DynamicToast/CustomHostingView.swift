//
//  CustomHostingView.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

final class CustomHostingView: UIHostingController<ToastView> {
    var isStatusBarHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
}
