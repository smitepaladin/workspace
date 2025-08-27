//
//  EditableMapView.swift
//  running
//
//  Created by HeartFluttery on 8/21/25.
//

import SwiftUI
import MapKit

// MARK: - Test 1
/// 실시간 트래킹용 지도 뷰
/// - 점 추가/삭제/드래그 기능 제거
/// - 외부에서 들어오는 coords 배열을 폴리라인으로 표시
//struct EditableMapView: View {
//    @Binding var coords: [CLLocationCoordinate2D]  // 외부에서 실시간 업데이트
//
//    @State private var camera: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060),
//            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        )
//    )
//
//    var body: some View {
//        Map(position: $camera) {
//            // 실시간 경로 폴리라인
//            if coords.count >= 2 {
//                MapPolyline(coordinates: coords)
//                    .stroke(.blue, lineWidth: 3)
//            }
//        }
////        .onChange(of: coords) { newCoords in
////            // 마지막 좌표로 카메라 이동
////            if let last = newCoords.last {
////                camera = .region(
////                    MKCoordinateRegion(
////                        center: last,
////                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
////                    )
////                )
////            }
////        }
//    }
//}
// MARK: - Test 2
//struct EditableMapView: View {
//    @Binding var coords: [CLLocationCoordinate2D]    // 점 좌표
//    var initialCenter: CLLocationCoordinate2D? = nil // 초기 지도 중심
//
//    // MapKit 카메라 상태
//    @State private var camera: MapCameraPosition
//
//    // 초기화: 초기 중심이 있으면 거기로, 없으면 기본 좌표 사용
//    init(coords: Binding<[CLLocationCoordinate2D]>, initialCenter: CLLocationCoordinate2D? = nil) {
//        self._coords = coords
//        self.initialCenter = initialCenter
//        if let center = initialCenter {
//            _camera = State(initialValue: .region(MKCoordinateRegion(center: center,
//                                                                    span: MKCoordinateSpan(latitudeDelta: 0.01,
//                                                                                           longitudeDelta: 0.01))))
//        } else {
//            _camera = State(initialValue: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060),
//                                                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
//        }
//    }
//
//    var body: some View {
//        Map(position: $camera) {
//            // 1️⃣ 폴리라인 표시
//            if coords.count >= 2 {
//                MapPolyline(coordinates: coords)
//                    .stroke(.blue, lineWidth: 3)
//            }
//
//            // 2️⃣ 점 표시
//            ForEach(coords.indices, id: \.self) { i in
//                Annotation("", coordinate: coords[i]) {
//                    Circle()
//                        .fill(Color.red)
//                        .frame(width: 12, height: 12)
//                }
//            }
//        }
//        .onTapGesture { location in
//            // 지도 탭하면 해당 좌표 추가
//            if let coord = locationCoordinate(from: location) {
//                coords.append(coord)
//            }
//        }
//    }
//
//    // CGPoint → CLLocationCoordinate2D 변환 (MapKit Preview용)
//    private func locationCoordinate(from point: CGPoint) -> CLLocationCoordinate2D? {
//        // MapReader 등 실제 변환이 필요하면 여기서 proxy 활용 가능
//        // Preview에서는 단순 더미 좌표 반환
//        if let center = initialCenter {
//            return center
//        } else {
//            return CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060)
//        }
//    }
//}

// MARK: - Test 3
//struct EditableMapView: View {
//    @State private var coords: [CLLocationCoordinate2D] = []
//    @State private var camera = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.52159, longitude: 127.01329), // 잠원한강공원
//            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        )
//    )
//
//    var body: some View {
//        MapReader { proxy in
//            Map(position: $camera) {
//                if coords.count > 1 {
//                    MapPolyline(coordinates: coords)
//                        .stroke(.blue, lineWidth: 4)
//                }
//                ForEach(coords, id: \.self) { coord in
//                    MapMarker(coordinate: coord, tint: .red)
//                }
//            }
//            .gesture(
//                DragGesture().onEnded { _ in
//                    if case .region(let region) = camera {
//                        coords.append(region.center)
//                    }
//                }
//            )
//        }
//    }
//
//    /// 저장할 때 경로 가져가기 위해 외부에서 접근할 수 있도록 제공
//    func getCoordinates() -> [CLLocationCoordinate2D] {
//        return coords
//    }
//}

// MARK: - onMapCameraChange
struct EditableMapView: View {
    @Binding var coords: [CLLocationCoordinate2D]

    @State private var camera: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5175, longitude: 127.0060),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    // 연속 추가 방지(쓰로틀/디바운스 비슷한 역할)
    @State private var lastAppendAt: TimeInterval = 0
    private let minTimeGap: TimeInterval = 0.08      // 최소 시간 간격(초)
    private let minDistanceMeters: CLLocationDistance = 2  // 최소 거리 간격(미터)

    var body: some View {
        Map(position: $camera) {
            if coords.count >= 2 {
                MapPolyline(coordinates: coords)
                    .stroke(.blue, lineWidth: 3)
            }
        }
        // 드래그 등으로 카메라가 움직일 때 연속 호출
        .onMapCameraChange(frequency: .continuous) { context in
            let center = context.region.center   // 또는: context.camera.centerCoordinate
            maybeAppend(center)
        }
    }

    private func maybeAppend(_ p: CLLocationCoordinate2D) {
        let now = CACurrentMediaTime()
        guard now - lastAppendAt >= minTimeGap else { return }

        if let last = coords.last {
            let d = MKMapPoint(p).distance(to: MKMapPoint(last))
            guard d >= minDistanceMeters else { return }
        }

        coords.append(p)
        lastAppendAt = now
    }
}
