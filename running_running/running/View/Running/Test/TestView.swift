//
//  TestView.swift
//  running
//
//  Created by HeartFluttery on 8/20/25.
//

import SwiftUI
import CoreLocation

// MARK: - Test 1
struct TestView: View {
    @StateObject private var engine = TrackingEngine()
    @StateObject private var locationService = LocationService()
    @State private var currentLocation: CLLocationCoordinate2D?

    // 예시 목표 경로: 잠원한강공원 주변
    private let targetCoords = [
        CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060),
        CLLocationCoordinate2D(latitude: 37.5180, longitude: 127.0070),
        CLLocationCoordinate2D(latitude: 37.5190, longitude: 127.0080)
    ]

    var body: some View {
        VStack {
            RunMapView(coords: $engine.coords,
                       targetCoords: targetCoords,
                       followUser: true,
                       currentLocation: $currentLocation)

            HStack {
                Button("Start") {
                    engine.attach(locationService)
                    locationService.requestAuth()
                    locationService.start()
                    engine.start()

                    // 위치 업데이트 바인딩
                    locationService.onLocation = { loc in
                        self.currentLocation = loc.coordinate
                    }
                }
                Button("Pause") { engine.pause() }
                Button("Resume") { engine.resume() }
                Button("Stop") { engine.stop(); locationService.stop() }
            }
        }
    }
}

// MARK: - Test 2
//struct TestView: View {
//    var body: some View {
//        TabView {
//            CreateRouteView()
//                .tabItem { Label("경로 작성", systemImage: "pencil") }
//
//            RunMapView(targetCoords: [
//                CLLocationCoordinate2D(latitude: 37.52159, longitude: 127.01329),
//                CLLocationCoordinate2D(latitude: 37.52027, longitude: 127.01316)
//            ])
//                .tabItem { Label("경로 실행", systemImage: "figure.walk") }
//        }
//    }
//}

#Preview {
    TestView()
}
