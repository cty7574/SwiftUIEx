//
//  String+Ext.swift
//  DynamicChipsUI
//
//  Created by 멘태 on 12/2/25.
//

import SwiftUI

extension String {
    func size(_ font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        return size(withAttributes: attributes)
    }
}
