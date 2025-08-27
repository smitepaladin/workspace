//
//  ContentView.swift
//  Map
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var selctedMapType = 0 // 선택탭
    
    // 서대문 형무소 역사관
    @State var map1 = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.57244171, longitude: 126.9595412), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // span은 초기 zoom크기
    ))
    
    // 둘리뮤지엄
    @State var map2 = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.65243153, longitude: 127.0276397), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // span은 초기 zoom크기
    ))
    
    // GPS
    @StateObject private var locationManager = LocationManager()
    // Camera Position의 초기값 설정
    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    
    @State var latitude2: Double = 0
    @State var longitude2: Double = 0
    
    var body: some View {
        VStack(content: {
            Text("Map")
                .bold()
            
            Picker(selection: $selctedMapType, label: Text("Map Type")){
                Text("서대문 형무소 역사관").tag(0)
                Text("둘리 뮤지엄").tag(1)
                Text("현재 위치").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selctedMapType == 0{
                Map(position: $map1){
                    Marker("서대문 형무소 역사관", systemImage: "signpost.left.fill", coordinate: CLLocationCoordinate2D(latitude: 37.57244171, longitude: 126.9595412))
                }
                .ignoresSafeArea(.all)
            }else if selctedMapType == 1{
                Map(position: $map2){
                    Marker("둘리 뮤지엄", systemImage: "signpost.left.fill", coordinate: CLLocationCoordinate2D(latitude: 37.65243153, longitude: 127.0276397))
                }
                .ignoresSafeArea(.all)
            }else{
                Map(position: $region){
                    // Marker의 Shape
                    UserAnnotation(anchor: .bottom){
                        VStack(content: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundStyle(.blue)
                                .frame(width: 30, height: 30)
                            Text("현재 위치")
                                .font(.caption)
                                .foregroundStyle(.black)
                                .background(Color.white.opacity(0.7))
                                .clipShape(.buttonBorder)
                        })
                    }
                }
            }
        }) // VStack
        //첫실행
        .onReceive(locationManager.$location, perform: {location in
            print("Receive")
            if let location = location{
                region = .region(MKCoordinateRegion(
                    center: location,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                ))
            }
        })
    }//Body
}//View

#Preview {
    ContentView()
}
