//
//  CustomMapView.swift
//  InteractiveMapCarousel
//
//  Created by 멘태 on 12/5/25.
//

import SwiftUI
import MapKit

struct CustomMapView: View {
    var userRegion: MKCoordinateRegion
    var userCoordinates: CLLocationCoordinate2D
    var lookupText: String
    var limit: Int
    
    @State private var cameraPosition: MapCameraPosition
    @State private var places: [Place] = []
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    init(userRegion: MKCoordinateRegion, userCoordinates: CLLocationCoordinate2D, lookupText: String, limit: Int = 10) {
        self.userRegion = userRegion
        self.userCoordinates = userCoordinates
        self.lookupText = lookupText
        self.limit = limit
        self._cameraPosition = .init(initialValue: .region(userRegion))
    }
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition)
                .navigationTitle("Nearby Places")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        if #available(iOS 26, *) {
                            Button(role: .close) {
                                dismiss()
                            }
                        } else {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.primary)
                            }

                        }
                    }
                }
        }
    }
}

#Preview {
    CustomMapView(
        userRegion: .applePark,
        userCoordinates: MKCoordinateRegion.applePark.center,
        lookupText: "Starbucks"
    )
}
