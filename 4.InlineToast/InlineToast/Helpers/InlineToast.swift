//
//  InlineToast.swift
//  InlineToast
//
//  Created by 멘태 on 11/14/25.
//

import SwiftUI

extension View {
    func inlineToast(config: InlineToastConfig, isPresented: Bool) -> some View {
        VStack(spacing: 10) {
            if config.anchor == .bottom {
                self
                    .compositingGroup()
            }
            
            if isPresented {
                InlineToastView(config: config)
                    .transition(.asymmetric(
                        insertion: .push(from: config.anchor.edge),
                        removal: .push(from: config.anchor.reversedEdge)
                    ))
            }
            
            if config.anchor == .top {
                self
                    .compositingGroup()
            }
        }
        .clipped()
    }
}

struct InlineToastConfig {
    var icon: String
    var title: String
    var subTitle: String
    var tint: Color
    var anchor: InlineToastAnchor = .top
    var actionIcon: String
    var actionHandler: () -> Void = { }
    
    enum InlineToastAnchor {
        case top, bottom
        
        var edge: Edge {
            self == .top ? .top : .bottom
        }
        
        var reversedEdge: Edge {
            self == .top ? .bottom : .top
        }
    }
}
