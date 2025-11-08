//
//  CardView.swift
//  StickyHeaderList
//
//  Created by 멘태 on 11/8/25.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text("Cookies")
                    .font(.title.bold())
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.callout)
                    .lineLimit(2)
                    .foregroundStyle(.gray)
                
                Text("$15.98")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.1))
                .frame(width: 100, height: 100)
        }
        .redacted(reason: .placeholder)
        .padding(10)
        .padding(.leading, 10)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 30))
        .padding(.horizontal)
    }
}
