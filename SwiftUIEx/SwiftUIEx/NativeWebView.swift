//
//  WebView.swift
//  SwiftUIEx
//
//  Created by 멘태 on 11/3/25.
//

import SwiftUI
import WebKit

struct NativeWebView: View {
    @State private var page: WebPage = WebPage()
    
    var body: some View {
        //WebView(url: url)
        
        WebView(page)
            .webViewMagnificationGestures(.disabled) // 확대, 축소 비활성화
            .onAppear {
                page.load(url)
            }
    }
    
    var url: URL? {
        URL(string: "https://developer.apple.com")
    }
}

#Preview {
    NativeWebView()
}
