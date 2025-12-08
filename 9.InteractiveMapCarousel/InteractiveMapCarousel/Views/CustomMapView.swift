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
    
    var animation: Animation { .smooth(duration: 0.45, extraBounce: 0) }
    
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
                .overlay {
                    loadingOverlay()
                }
                .safeAreaInset(edge: .bottom, spacing: 0, content: {
                    GeometryReader { proxy in
                        let size: CGSize = proxy.size
                        
                        bottomCarousel(size.width)
                        
                        if places.isEmpty {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                                .frame(width: size.width, height: size.height)
                        }
                    }
                    .frame(height: 200)
                })
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
        .onAppear {
            guard places.isEmpty else { return }
            fetchPlaces()
        }
    }
    
    @ViewBuilder
    private func loadingOverlay() -> some View {
        Rectangle()
            .fill(.black.opacity(places.isEmpty ? 0.35 : 0))
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func bottomCarousel(_ width: CGFloat) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(places) { place in
                    bottomCarousel(place)
                        .padding(.horizontal)
                        .frame(width: width)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .scrollTargetBehavior(.paging)
    }
    
    @ViewBuilder
    private func bottomCarousel(_ place: Place?) -> some View {
        VStack(alignment: .leading) {
            if let place {
                Text(place.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(place.address)
                    .lineLimit(2)
                
                if let phoneNumber = place.phoneNumber, let url = URL(string: "tel:\(phoneNumber)") {
                    Link("Phone Number: **\(phoneNumber)**", destination: url)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Learn More")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .buttonBorderShape(.capsule)

            } else {
                Group {
                    Text("PLACEHOLDER NAME")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Some random address here, for a placeholder reason, Thanks!")
                        .lineLimit(2)
                    
                    Text("Some Phone Number Here")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Learn More")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .buttonBorderShape(.capsule)
                    .disabled(true)
                }
                .redacted(reason: .placeholder)
            }
        }
        .padding()
        .optionalGlassEffect(colorScheme)
    }
    
    private func fetchPlaces() {
        Task {
            let request = MKLocalSearch.Request()
            request.region = userRegion
            request.naturalLanguageQuery = lookupText
            
            let search = MKLocalSearch(request: request)
            if let items = try? await search.start().mapItems {
                let places: [Place] = items.compactMap { item in
                    let name = item.name ?? "Unknown"
                    var coordinates: CLLocationCoordinate2D
                    
                    if #available(iOS 26, *) {
                        coordinates = item.location.coordinate
                    } else {
                        coordinates = item.placemark.coordinate
                    }
                    
                    return Place(name: name, coordinates: coordinates, mapItem: item)
                }
                    .prefix(limit).compactMap { $0 }
                
                withAnimation(animation) {
                    self.places = places
                }
            }
        }
    }
}

#Preview {
    CustomMapView(
        userRegion: .applePark,
        userCoordinates: MKCoordinateRegion.applePark.center,
        lookupText: "Starbucks",
        limit: 3
    )
}
