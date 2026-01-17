//
//  DynamicIslandToastViewModifier.swift
//  DynamicIslandToast
//
//  Created by 멘태 on 1/17/26.
//

import SwiftUI

struct DynamicIslandToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    var value: Toast
    
    func body(content: Content) -> some View {
        content 
    }
}
