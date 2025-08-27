//
//  RunWithTargetView.swift
//  running
//
//  Created by HeartFluttery on 8/21/25.
//

import SwiftUI
import CoreLocation

struct RunWithTargetView: View {
    @State var targetCoords: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060),
        CLLocationCoordinate2D(latitude: 37.5180, longitude: 127.0070)
    ]
    @StateObject var locationService = LocationService()
    @StateObject var tracking = TrackingEngine()
    @State private var currentLocation: CLLocationCoordinate2D?

    var body: some View {
        RunMapView(coords: $tracking.coords,
                   targetCoords: targetCoords,
                   followUser: true,
                   currentLocation: $currentLocation)
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


#Preview {
    RunWithTargetView()
}
