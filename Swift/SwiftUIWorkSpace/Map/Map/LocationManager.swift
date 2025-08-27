//
//  LocationManager.swift
//  Map
//
//  Created by Jun Jong Eck on 8/7/25.
//

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    
    override init() {
        super.init()
        locationManager.delegate = self // delegate 는 대리인이다. class를 복사해온다.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 best로 주세요
        locationManager.requestWhenInUseAuthorization() // 권한요구
        locationManager.startUpdatingLocation() // 현재위치 가져오기
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // CLLocation는 리스트, didUpDateLocations는 ContentView에서 불러올 때 쓸 변수
        guard let location = locations.last?.coordinate else { return } // GPS를 못받았을 경우를 가정해서 guard let, last는 다 가져오는거고 coordinate로 위도경도만 걸러냄. ?를 쓴 이유는 못받았을 경우 return으로 보내기 위해
        self.location = location // 앞의 location은 전역변수
    }
    

}
