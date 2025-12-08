//
//  Place.swift
//  InteractiveMapCarousel
//
//  Created by 멘태 on 12/5/25.
//

import Foundation
import MapKit

struct Place: Identifiable {
    var id: UUID = UUID()
    var name: String    
    var coordinates: CLLocationCoordinate2D
    var mapItem: MKMapItem
    
    var address: String {
        if #available(iOS 26, *) {
            return mapItem.address?.fullAddress ?? ""
        } else {
            return mapItem.placemark.title ?? ""
        }
    }
    
    var phoneNumber: String? {
        return  mapItem.phoneNumber
    }
}
