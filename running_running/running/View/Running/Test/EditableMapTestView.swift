//
//  Untitled.swift
//  running
//
//  Created by HeartFluttery on 8/21/25.
//

import SwiftUI
import MapKit

struct EditableMapTestView: View {
    @State private var coords: [CLLocationCoordinate2D] = []

    var body: some View {
        VStack {
            EditableMapView(coords: $coords)
                .frame(height: 400)

            Text("좌표 개수: \(coords.count)")
        }
    }
}


#Preview {
    EditableMapTestView()
}
