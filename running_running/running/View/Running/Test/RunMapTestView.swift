//
//  SwiftUIView.swift
//  running
//
//  Created by HeartFluttery on 8/21/25.
//

import SwiftUI
import CoreLocation

struct RunMapTestView: View {
    @StateObject var locationService = LocationService()
    @StateObject var tracking = TrackingEngine()
    @State private var currentLocation: CLLocationCoordinate2D?

    var body: some View {
        VStack {
            RunMapView(coords: $tracking.coords, targetCoords: [], followUser: true, currentLocation: $currentLocation)
                .frame(height: 400)
            
            Text("거리: \(tracking.distanceKm, specifier: "%.2f") km")
            Text("페이스: \(tracking.formattedPace)")
        }
        .onAppear {
            locationService.requestAuth()
            tracking.attach(locationService)
            tracking.start()
        }
        .onDisappear {
            tracking.stop()
        }
    }
}

#Preview {RunMapTestView()}
