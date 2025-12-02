//
//  SubviewsCollection.swift
//  DynamicChipsUI
//
//  Created by 멘태 on 12/1/25.
//

import SwiftUI

extension SubviewsCollection {
    // 행 사이즈 동적 계산
    func chunkByWidth(_ containerWidth: CGFloat) -> [[Subview]] {
        var row: [Subview] = []
        var rows: [[Subview]] = []
        var rowWidth: CGFloat = 0
        var spacing: CGFloat = 10
        
        for subview in self {
            let viewWidth: CGFloat = subview.containerValues.viewWidth + spacing
            
            rowWidth += viewWidth
            
            if rowWidth < containerWidth {
                row.append(subview)
            } else {
                rows.append(row)
                row = [subview]
                rowWidth = viewWidth
            }
        }
        
        if !row.isEmpty {
            rows.append(row)
        }
        
        return rows
    }
    
    // 행 사이즈 정적 계산
    func chunked(_ size: Int) -> [[Subview]] {
        return stride(from: 0, to: count, by: size).map { index in
            Array(self[index..<Swift.min(index + size ,count)])
        }
    }
}
