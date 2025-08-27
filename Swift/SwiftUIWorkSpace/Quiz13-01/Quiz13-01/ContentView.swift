//
//  ContentView.swift
//  Quiz13-01
//
//  Created by Jun Jong Eck on 8/7/25.
//


import SwiftUI
import MapKit

struct ContentView: View {
    @State private var currentPage = 0
    var mapName = ["혜화문", "흥인지문", "창의문", "숙정문"]
    var mapLatitude = [37.5878892, 37.5711907, 37.5926027, 37.5956584]
    var mapLongitude = [127.0037098, 127.009506, 126.9664771, 126.9810576]
    
    @State var markerName = CLLocationCoordinate2D(latitude: 37.5878892, longitude: 127.0037098)

    @State var mapLoc =  MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5878892, longitude: 127.0037098),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    
    var body: some View {
        
        VStack(content: {
            TabView(selection: $currentPage,
                    content:  {
                ForEach(0..<mapName.count, id: \.self, content: { index in
                    VStack(content: {
                        Text(mapName[index])
                            .bold()
                            .font(.system(size: 25))
                            .padding()
                        
                        Map(position: $mapLoc){
                            Marker(mapName[index], systemImage: "signpost.left.fill", coordinate: markerName)
                        }
                    })
                    .tag(index)
                    .onAppear(perform: {
                        mapLoc = MapCameraPosition.region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: mapLatitude[index], longitude: mapLongitude[index]),
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        ))
                        
                        markerName = CLLocationCoordinate2D(latitude: mapLatitude[index], longitude: mapLongitude[index])
                    })
                })
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onAppear(perform: {
                UIPageControl.appearance().currentPageIndicatorTintColor = .red
                UIPageControl.appearance().pageIndicatorTintColor = .green
            })
        })
    }
}

#Preview {
    ContentView()
}
