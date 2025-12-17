//
//  View+Ext.swift
//  AnimatedTabBar
//
//  Created by 멘태 on 12/17/25.
//

import UIKit

extension UIView {
    func subviews<T: UIView>(type: T.Type) -> [T] {
        return subviews.compactMap { $0 as? T } + subviews.flatMap { $0.subviews(type: type)}
    }
}
