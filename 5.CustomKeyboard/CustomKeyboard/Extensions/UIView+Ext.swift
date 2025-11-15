//
//  UIView+Ext.swift
//  CustomKeyboard
//
//  Created by 멘태 on 11/15/25.
//

import SwiftUI

extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}
