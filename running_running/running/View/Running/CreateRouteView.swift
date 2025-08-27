//
//  CreateRouteView.swift
//  running
//
//  Created by HeartFluttery on 8/21/25.
//

import SwiftUI
import FirebaseFirestore
import CoreLocation
import MapKit

// MARK: - Test 1
struct CreateRouteView: View {
    @State private var coords: [CLLocationCoordinate2D] = []
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var expectedTime: String = ""
    
    let db = Firestore.firestore()
    let userId = "user001" // 임시 유저 ID

    var body: some View {
        VStack {
            EditableMapView(coords: $coords)
                .frame(height: 400)
            
            Form {
                TextField("코스 제목", text: $title)
                TextField("설명", text: $description)
                TextField("예상 소요 시간 (분)", text: $expectedTime)
                    .keyboardType(.numberPad)
            }

            HStack {
                Button("저장") { saveRoute() }
                Button("취소") { coords.removeAll() }
            }
        }
    }
    
    func saveRoute() {
        guard let time = Int(expectedTime), !title.isEmpty, !coords.isEmpty else { return }
        
        let geoCoords = coords.map { GeoPoint(latitude: $0.latitude, longitude: $0.longitude) }

        let route = RunningRoute(
            title: title,
            description: description,
            expectedTime: time,
            createdBy: userId,
            createdAt: Date(),
            path: geoCoords
        )
        
        do {
            _ = try db.collection("routes").addDocument(from: route)
            print("저장 완료!")
        } catch {
            print("Firestore 저장 실패:", error)
        }
    }
}

#Preview {
    CreateRouteView()
}

// MARK: - Test 2
//struct CreateRouteView: View {
//    @State private var coords: [CLLocationCoordinate2D] = []   // 폴리라인 좌표 배열
//    @State private var currentLocation: CLLocationCoordinate2D? = nil
//    
//    @State private var title: String = ""
//    @State private var description: String = ""
//    @State private var expectedTime: String = ""
//    
//    private let locationManager = CLLocationManager()
//    
//    var body: some View {
//        VStack {
//            // 1️⃣ 지도: 폴리라인 표시, 중심은 currentLocation
//            TrackingMapView(coords: $coords, initialCenter: currentLocation)
//                .frame(height: 400)
//            
//            // 2️⃣ 폼: 경로 정보 입력
//            Form {
//                TextField("코스 제목", text: $title)
//                TextField("설명", text: $description)
//                TextField("예상 소요 시간 (분)", text: $expectedTime)
//                    .keyboardType(.numberPad)
//            }
//
//            // 3️⃣ 버튼: 저장 / 취소
//            HStack {
//                Button("저장") {
//                    // Firestore 저장 로직 넣을 수 있음
//                    print("coords:", coords)
//                }
//                Button("취소") {
//                    coords.removeAll()
//                }
//            }
//        }
//        .onAppear {
//            // 위치 권한 요청
//            locationManager.requestWhenInUseAuthorization()
//            if CLLocationManager.locationServicesEnabled() {
//                locationManager.delegate = LocationDelegate { loc in
//                    currentLocation = loc.coordinate
//                    // coords 배열에 추가 → 폴리라인 표시
//                    coords.append(loc.coordinate)
//                }
//                locationManager.startUpdatingLocation()
//            }
//        }
//    }
//}
//
////
////  TrackingMapView.swift
////  현재 위치 따라 폴리라인 표시용 Map
////
//struct TrackingMapView: View {
//    @Binding var coords: [CLLocationCoordinate2D]
//    var initialCenter: CLLocationCoordinate2D?
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
//            // 폴리라인 그리기
//            MapPolyline(coordinates: coords)
//                .stroke(.blue, lineWidth: 3)
//        }
//
//        .onAppear {
//            // 초기 중심 설정
//            if let center = initialCenter {
//                camera = .region(
//                    MKCoordinateRegion(
//                        center: center,
//                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                    )
//                )
//            }
//        }
//    }
//}
//
//// CLLocationManager Delegate 래핑
//class LocationDelegate: NSObject, CLLocationManagerDelegate {
//    var onLocation: (CLLocation) -> Void
//    
//    init(onLocation: @escaping (CLLocation) -> Void) {
//        self.onLocation = onLocation
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let loc = locations.last else { return }
//        onLocation(loc)
//    }
//}


// MARK: - Test 3
// import FirebaseFirestore

//struct CreateRouteView: View {
//    @State private var routeName: String = ""
//    @State private var savedMessage: String = ""
//    
//    @State private var mapView = EditableMapView()
//
//    var body: some View {
//        VStack {
//            TextField("경로 이름 입력", text: $routeName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            mapView
//                .frame(height: 400)
//
//            Button("경로 저장하기") {
//                let coords = mapView.getCoordinates()
//                saveRoute(name: routeName, coords: coords)
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//
//            Text(savedMessage)
//                .foregroundColor(.green)
//                .padding()
//        }
//    }
//
//    func saveRoute(name: String, coords: [CLLocationCoordinate2D]) {
//        guard !name.isEmpty, !coords.isEmpty else {
//            savedMessage = "경로 이름과 좌표를 입력하세요."
//            return
//        }
//
//        // Firestore 저장 예시
//        /*
//        let db = Firestore.firestore()
//        let routeData: [String: Any] = [
//            "name": name,
//            "coords": coords.map { ["lat": $0.latitude, "lng": $0.longitude] }
//        ]
//        db.collection("routes").addDocument(data: routeData) { error in
//            if let error = error {
//                savedMessage = "저장 실패: \(error.localizedDescription)"
//            } else {
//                savedMessage = "경로 저장 성공!"
//            }
//        }
//        */
//        savedMessage = "테스트: \(name) 저장됨 (\(coords.count)개 좌표)"
//    }
//}
//#Preview {
//    CreateRouteView()
//}
