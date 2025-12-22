//
//  ContentView.swift
//  AnimatedBottomBar
//
//  Created by 멘태 on 12/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            let fillColor: Color = .gray.opacity(0.15)
            AnimatedBottomBar(hint: "Type Here", text: $text, isFocused: $isFocused) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(fillColor, in: .circle)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(fillColor, in: .circle)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "mic.fill")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(fillColor, in: .circle)
                }
            } trailingAction: {
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(fillColor, in: .circle)
                }
            } mainAction: {
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(fillColor, in: .circle)
                }

            }

        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

#Preview {
    ContentView()
}
