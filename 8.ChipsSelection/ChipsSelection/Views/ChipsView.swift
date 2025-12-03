//
//  ChipsView.swift
//  ChipsSelection
//
//  Created by 멘태 on 12/3/25.
//

import SwiftUI

struct ChipsView<Content: View, Tag: Equatable>: View where Tag: Hashable {
    var spacing: CGFloat = 10
    var tags: [Tag]
    @ViewBuilder var content: (Tag, Bool) -> Content
    var didChangeSelection: ([Tag]) -> ()
    @State private var selectedTags: [Tag] = []
    
    var body: some View {
        CustomChipLayout(spacing: spacing) {
            ForEach(tags, id: \.self) { tag in
                content(tag, selectedTags.contains(tag))
            }
        }
    }
}

fileprivate struct CustomChipLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        
        for subview in subviews {
            let fitSize = subview.sizeThatFits(proposal)
            
            if origin.x + fitSize.width > bounds.maxX {
                origin.x = bounds.minX
                origin.y += fitSize.height + spacing
                
                subview.place(at: origin, proposal: proposal)
                origin.x += fitSize.width + spacing
            } else {
                subview.place(at: origin, proposal: proposal)
                origin.x += fitSize.width + spacing
            }
        }
    }
}

#Preview {
    ContentView()
}
