//
//  TrackPoint.swift
//  running
//
//  Created by HeartFluttery on 8/20/25.
//

import CoreLocation

/// 지도 폴리라인/차트 등에 쓰기 위한 1개의 트랙 포인트
struct TrackPoint: Identifiable, Codable {
    var id = UUID()
    let ts: Date                        // 기록 시각
    let coord: CLLocationCoordinate2D   // 위도/경도
    let accuracy: Double                // 수평 정확도(미터)
    let speedMS: Double               // 계산된 속도 (m/s)
}

// CLLocationCoordinate2D Codable 지원 확장
extension CLLocationCoordinate2D: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(latitude)
        try container.encode(longitude)
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let lat = try container.decode(CLLocationDegrees.self)
        let lon = try container.decode(CLLocationDegrees.self)
        self.init(latitude: lat, longitude: lon)
    }
}
