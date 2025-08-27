//
//  TrackingEngine.swift
//  running
//
//  Created by HeartFluttery on 8/20/25.
//

import CoreLocation
import Combine


/// 위치 추적 세션을 관리하는 엔진
/// - start/pause/resume/stop 으로 제어
/// - 1초 타이머로 경과 시간과 페이스 갱신
/// - ingest(_:) 로 들어오는 CLLocation을 품질 필터 후 누적
final class TrackingEngine: ObservableObject {

    // MARK: - 공개 상태 (SwiftUI 바인딩용)
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var elapsed: TimeInterval = 0            // 총 경과시간(초)
    @Published private(set) var distance: CLLocationDistance = 0     // 누적거리(m)
    @Published private(set) var paceSecPerKm: Double = 0             // 페이스(초/킬로미터)
    @Published private(set) var points: [TrackPoint] = []            // 궤적 점들
    
    // 좌표만 뽑아서 Published
    @Published var coords: [CLLocationCoordinate2D] = []

    // MARK: - 내부 상태
    private var timer: Timer?
    private var startedAt: Date?
    private var lastLoc: CLLocation?
    private var filterLast: CLLocation?

    // MARK: - 품질 필터
    /// 간단한 위치 품질 필터:
    /// - 정확도 0~25m 이내만 허용
    /// - 이전 지점 대비 7 m/s 초과로 "점프"하면서 정확도까지 나빠지면 버림
    private func accept(_ loc: CLLocation) -> Bool {
        // 수평 정확도 체크
        guard loc.horizontalAccuracy > 0, loc.horizontalAccuracy <= 25 else { return false }

        // 비현실적 점프 제거
        if let prev = filterLast {
            let dt = loc.timestamp.timeIntervalSince(prev.timestamp)
            let d = loc.distance(from: prev)
            let v = d / max(dt, 0.1) // 0 나눗셈 방지
            if v > 7 /* m/s */ && loc.horizontalAccuracy > prev.horizontalAccuracy {
                return false
            }
        }
        filterLast = loc
        return true
    }

    // MARK: - 외부 LocationService 연결
    
    func addPoint(_ point: TrackPoint) {
            points.append(point)
            coords.append(point.coord)
    }
    
    /// LocationService의 onLocation 콜백에 자신을 연결
    func attach(_ svc: LocationService) {
        svc.onLocation = { [weak self] loc in
            self?.ingest(loc)
        }
    }

    // MARK: - 세션 제어
    func start() {
        isRunning = true
        startedAt = Date()

        // 누적 상태 초기화
        elapsed = 0
        distance = 0
        paceSecPerKm = 0
        points.removeAll()
        lastLoc = nil
        filterLast = nil

        // 1초 타이머: 경과시간/페이스 갱신
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self, let s = self.startedAt else { return }
            self.elapsed = Date().timeIntervalSince(s)
            self.recalcPace()
        }
        // 런루프 모드(스크롤 중에도 동작하도록) - 필요 시
        RunLoop.main.add(timer!, forMode: .common)
    }

    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func resume() {
        // 이전에 누적된 elapsed를 기준으로 시작 시각을 재설정
        startedAt = Date().addingTimeInterval(-elapsed)
        isRunning = true

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self, let s = self.startedAt else { return }
            self.elapsed = Date().timeIntervalSince(s)
            self.recalcPace()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        startedAt = nil
    }

    deinit {
        timer?.invalidate()
    }

    // MARK: - 핵심: 위치 흡수
    /// 외부(LocationService)에서 들어온 CLLocation을 받아 누적/계산
    private func ingest(_ loc: CLLocation) {
        // 세션이 멈춰 있으면 무시(원하면 기록만 하고 거리증가는 막는 모드로 바꿔도 됨)
        guard isRunning else { return }

        // 품질 필터
        guard accept(loc) else { return }

        var incDistance: CLLocationDistance = 0
        var speed: Double = 0

        if let prev = lastLoc {
            let dt = loc.timestamp.timeIntervalSince(prev.timestamp)
            let d = loc.distance(from: prev)
            if dt > 0 {
                speed = d / dt // m/s
            }
            incDistance = d
        }

        // 내부 상태 업데이트
        lastLoc = loc
        distance += incDistance

        // 트랙 포인트 저장 (UI 업데이트는 메인에서)
        let tp = TrackPoint(
            ts: loc.timestamp,
            coord: loc.coordinate,
            accuracy: loc.horizontalAccuracy,
            speedMS: max(speed, 0)
        )

        DispatchQueue.main.async {
            self.points.append(tp)
            self.recalcPace()
        }
    }

    // MARK: - 보조 계산
    private func recalcPace() {
        // pace = 총시간 / (거리(km))
        if distance > 0 {
            paceSecPerKm = elapsed / (distance / 1000.0)
        } else {
            paceSecPerKm = 0
        }
    }
}

// MARK: - 표시용 편의 프로퍼티
extension TrackingEngine {
    /// "mm'ss\"" 형식 페이스 문자열 (예: 5'12")
    var formattedPace: String {
        guard paceSecPerKm > 0 else { return "--'--\"" }
        let total = Int(paceSecPerKm.rounded())
        let m = total / 60
        let s = total % 60
        return String(format: "%d'%02d\"", m, s)
    }

    /// "hh:mm:ss" (1시간 미만이면 "mm:ss")
    var formattedElapsed: String {
        let t = Int(elapsed.rounded())
        let h = t / 3600
        let m = (t % 3600) / 60
        let s = t % 60
        return h > 0
        ? String(format: "%d:%02d:%02d", h, m, s)
        : String(format: "%02d:%02d", m, s)
    }

    /// 킬로미터 단위 거리
    var distanceKm: Double { distance / 1000.0 }
}
