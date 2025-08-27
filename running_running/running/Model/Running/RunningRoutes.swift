//
//  RunningRoutes.swift
//  running
//
//  Created by HeartFluttery on 8/21/25.
//

import FirebaseFirestore
import CoreLocation

struct RunningRoute: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String //경로 이름
    var description: String // 경로 설명
    var expectedTime: Int // 예상 산책 시간
    var createdBy: String // 작성자
    var createdAt: Date // 작성일
    var path: [GeoPoint] // 좌표
    
    var averageRating: Double? = nil  // 계산된 평균 별점
}

struct Rating: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String // 별점 준 사람 이름
    var value: Int // 1~5 별점
    var createdAt: Date // 평가일
}
