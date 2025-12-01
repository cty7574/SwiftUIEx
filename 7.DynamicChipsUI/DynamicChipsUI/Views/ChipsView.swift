//
//  ChipsView.swift
//  DynamicChipsUI
//
//  Created by 멘태 on 12/1/25.
//

import SwiftUI

struct ChipsView<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        Group(subviews: content) { collection in
            let chunkedCollection = collection.chunked(3)
            
            VStack(alignment: .center, spacing: 10) {
                ForEach(chunkedCollection.indices, id: \.self) { index in
                    HStack(spacing: 10) {
                        ForEach(chunkedCollection[index]) { subview in
                            subview 
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
