//
//  DetailView.swift
//  InteractiveMapCarousel
//
//  Created by 멘태 on 12/10/25.
//

import SwiftUI

struct DetailView: View {
    var place: Place
    
    var body: some View {
        Text("This is a detail view")
            .presentationDetents([.medium])
    }
}
