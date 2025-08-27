//
//  LocationService.swift
//  running
//
//  Created by HeartFluttery on 8/20/25.
//

import CoreLocation
import Combine

final class LocationService: NSObject, ObservableObject {
    @Published var latest: CLLocation?
    let manager = CLLocationManager()
    var onLocation: ((CLLocation) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
        manager.distanceFilter = 5      // 5m 이동 시 업데이트
        manager.pausesLocationUpdatesAutomatically = true
        manager.allowsBackgroundLocationUpdates = false // 필요 시
    }

    func requestAuth() {
        // 백그라운드까지 필요하면 requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        // 포그라운드만이면: manager.requestWhenInUseAuthorization()
    }

    func start() { manager.startUpdatingLocation() }
    func stop()  { manager.stopUpdatingLocation() }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ m: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse { start() }
    }
    func locationManager(_ m: CLLocationManager, didUpdateLocations locs: [CLLocation]) {
        guard let loc = locs.last else { return }
        latest = loc
        onLocation?(loc)
    }
    func locationManager(_ m: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error)
    }
}
