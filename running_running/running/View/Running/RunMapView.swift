//
//  RunMapView.swift
//  running
//
//  Created by HeartFluttery on 8/20/25.
//

import SwiftUI
import MapKit
import CoreLocation

// MARK: - Test 1
/// SwiftUI에서 MKMapView를 사용하기 위한 UIViewRepresentable 래퍼
/// - coords: 지도에 그릴 좌표 배열 (바뀔 때마다 updateUIView가 호출됨)
/// - followUser: 마지막 좌표로 카메라를 따라갈지 여부
struct RunMapView: UIViewRepresentable {
    @Binding var coords: [CLLocationCoordinate2D] // 기록된 경로
    var targetCoords: [CLLocationCoordinate2D] = [] // 목표 경로
    var followUser: Bool = true
    @Binding var currentLocation: CLLocationCoordinate2D?

    /// UIKit 델리게이트 역할을 하는 Coordinator
    /// - MKMapViewDelegate를 구현하여 오버레이(폴리라인)의 렌더러를 반환
    final class Coordinator: NSObject, MKMapViewDelegate {
        // 현재 지도에 추가된 폴리라인 레퍼런스(중복 제거/교체용)
        var polyline: MKPolyline?
        var targetAnnotations: [MKPointAnnotation] = []
        var currentAnnotation: MKPointAnnotation?

        // MKMapView가 오버레이를 그릴 때 호출되는 델리게이트 메서드
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            // 폴리라인을 그리기 위한 렌더러
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.lineWidth = 6                    // 선 굵기
            renderer.strokeColor = UIColor.systemBlue // 선 색상 (다크/라이트에 적절)
            renderer.lineJoin = .round                // 선 연결부 둥글게
            renderer.lineCap = .round                 // 선 끝부분 둥글게
            return renderer
        }
    }

    // Coordinator 인스턴스 생성
    func makeCoordinator() -> Coordinator { Coordinator() }

    // UIView 생성 (한 번만 호출)
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator        // 델리게이트 연결
        mapView.showsUserLocation = true             // 현재 위치 핀 보이기
        mapView.userTrackingMode = followUser ? .followWithHeading : .none
        
        // 초기 지도: 잠원한강공원 근처
        let jamwon = CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060)
        let region = MKCoordinateRegion(
            center: jamwon,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: false)
        
        // 목표 지점 마커 추가
        context.coordinator.targetAnnotations.forEach { mapView.removeAnnotation($0) }
        context.coordinator.targetAnnotations = targetCoords.map {
            let a = MKPointAnnotation()
            a.coordinate = $0
            a.title = "Target"
            return a
        }
        context.coordinator.targetAnnotations.forEach { mapView.addAnnotation($0) }
        
        // 필요 시 추가 설정(예: mapView.mapType = .mutedStandard)
        return mapView
    }

    // SwiftUI 상태(바인딩)가 바뀔 때마다 호출되어 UIView 갱신
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // 1) 기존 폴리라인이 있으면 제거(중복 방지)
        if let existing = context.coordinator.polyline {
            mapView.removeOverlay(existing)
            context.coordinator.polyline = nil
        }

        // 2) 유효한 좌표가 2개 이상 있어야 폴리라인 생성 가능
        guard coords.count >= 2 else {
            // 좌표가 적으면 지도에서 폴리라인을 표시하지 않음
            return
        }

        // 3) 새 폴리라인 생성 후 지도에 추가
        //    MKPolyline은 C 기반으로 좌표 배열을 복사하므로 coords의 라이프사이클에 영향 없음
        let poly = MKPolyline(coordinates: coords, count: coords.count)
        context.coordinator.polyline = poly
        mapView.addOverlay(poly)

        // 현재 위치 마커
        if let loc = currentLocation {
            if context.coordinator.currentAnnotation == nil {
                let a = MKPointAnnotation()
                a.coordinate = loc
                a.title = "You"
                context.coordinator.currentAnnotation = a
                mapView.addAnnotation(a)
            } else {
                context.coordinator.currentAnnotation?.coordinate = loc
            }

            // 따라 걷기: 카메라 이동
            if followUser {
                let region = MKCoordinateRegion(center: loc,
                                                latitudinalMeters: 400,
                                                longitudinalMeters: 400)
                mapView.setRegion(region, animated: true)
            }
        }
    }
}

// MARK: - Test 2
//class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var currentLocation: CLLocationCoordinate2D?
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        currentLocation = locations.last?.coordinate
//    }
//}
//
//struct RunMapView: View {
//    @StateObject private var locationService = LocationService()
//    var targetCoords: [CLLocationCoordinate2D]
//
//    @State private var camera = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.52159, longitude: 127.01329),
//            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        )
//    )
//
//    var body: some View {
//        Map(position: $camera) {
//            if targetCoords.count > 1 {
//                MapPolyline(coordinates: targetCoords)
//                    .stroke(.blue, lineWidth: 4)
//            }
//            ForEach(targetCoords, id: \.self) { coord in
//                MapMarker(coordinate: coord, tint: .red)
//            }
//
//            if let current = locationService.currentLocation {
//                MapMarker(coordinate: current, tint: .green)
//            }
//        }
//        .onChange(of: locationService.currentLocation) { newLocation in
//            if let newLocation = newLocation {
//                camera = .region(
//                    MKCoordinateRegion(
//                        center: newLocation,
//                        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//                    )
//                )
//            }
//        }
//    }
//}
