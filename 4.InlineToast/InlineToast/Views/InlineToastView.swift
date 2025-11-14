//
//  InlineToastView.swift
//  InlineToast
//
//  Created by 멘태 on 11/14/25.
//

import SwiftUI

struct InlineToastView: View {
    var config: InlineToastConfig
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: config.icon)
                .font(.title2)
                .foregroundStyle(config.tint)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(config.title)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                if !config.subTitle.isEmpty {
                    Text(config.subTitle)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()
            
            Button(action: config.actionHandler) {
                Image(systemName: config.actionIcon)
                    .foregroundStyle(.gray)
                    .contentShape(.rect)
            }
        }
        .padding()
        .background {
            ZStack {
                Rectangle()
                    .fill(.background)
                
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(config.tint)
                        .frame(width: 6)
                    
                    Rectangle()
                        .fill(config.tint.opacity(0.15))
                }
            }
        }
        .contentShape(.rect)
    }
}


