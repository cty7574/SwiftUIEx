//
//  ContentView.swift
//  StickyHeaderList
//
//  Created by 멘태 on 11/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomList { progress in
            navBarView(progress)
        } topContent: { progress, safeAreaTop in
            heroImage(progress, safeAreaTop)
        } header: { progress in
            headerView(progress)
        } content: {
            
        }
    }
    
    @ViewBuilder
    func heroImage(_ progress: CGFloat, _ safeAreaTop: CGFloat) -> some View {
        GeometryReader { proxy in
            let minY: CGFloat = proxy.frame(in: .global).minY
            let size: CGSize = proxy.size
            let height: CGFloat = size.height + (minY > 0 ? minY : 0)
            
            Image(systemName: "globe")
                .resizable()
                .padding()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height + safeAreaTop)
                .offset(y: minY > 0 ? -minY : 0)
                .offset(y: -safeAreaTop)
        }
        .frame(height: 250)
    }
    
    @ViewBuilder
    func headerView(_ progress: CGFloat) -> some View {
        VStack(alignment: .leading) {
            Text("Apple Foods")
                .font(.title2.bold())
                .frame(height: 35)
                .offset(x: min(progress * 1.1, 1) * 45)
            
            let opacity: CGFloat = max(0, 1 - (progress * 1.2))
            let currentMenuTitleOpacity: CGFloat = max(progress - 0.9, 0) * 10
            
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.caption)
                
                Text("4.5 **(20K ratings)**")
                    .font(.callout)
                
                Image(systemName: "clock")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.leading, 10)
                
                Text("35-40 **Mins**")
                    .font(.callout)
            }
            .opacity(opacity)
            .overlay(alignment: .leading) {
                Text("Order Again")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .fontWeight(.medium)
                    .contentTransition(.numericText())
                    .offset(x: 45, y: -5)
                    .opacity(currentMenuTitleOpacity)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            // 스크롤 진행도가 0.8 이상일 때, background progress 값을 0-1 범위로 보정
            let backgroundProgress: CGFloat = max(progress - 0.8, 0) * 5
            
            Rectangle()
                .fill(.background)
                .padding(.top, backgroundProgress * -100)
                .shadow(color: .gray.opacity(backgroundProgress * 0.3), radius: 5, x: 0, y: 2)
        }
    }
    
    @ViewBuilder
    func navBarView(_ progress: CGFloat) -> some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.primary, .background)
                    .shadow(radius: 2)
                    .frame(height: 35)
            }
            
            Spacer()

            Button {
                
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.primary, .background)
                    .shadow(radius: 2)
                    .frame(height: 35)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    ContentView()
}
