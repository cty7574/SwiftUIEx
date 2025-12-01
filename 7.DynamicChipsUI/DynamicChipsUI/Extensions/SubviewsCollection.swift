//
//  SubviewsCollection.swift
//  DynamicChipsUI
//
//  Created by 멘태 on 12/1/25.
//

import SwiftUI

extension SubviewsCollection {
    func chunked(_ size: Int) -> [[Subview]] {
        return stride(from: 0, to: count, by: size).map { index in
            Array(self[index..<Swift.min(index + size ,count)])
        }
    }
}
