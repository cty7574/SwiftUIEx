//
//  MKCoordinateRegion.swift
//  InteractiveMapCarousel
//
//  Created by 멘태 on 12/5/25.
//

import MapKit

extension MKCoordinateRegion {
    static var applePark: Self {
        Self(
            center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090),
            latitudinalMeters: 250000,
            longitudinalMeters: 250000
        )
    }
}
