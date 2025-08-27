//
//  ContentView.swift
//  CollectionView_Image
//
//  Created by Jun Jong Eck on 8/7/25.
//


import SwiftUI

struct ContentView: View {
    @State var dataArray: [String] = [
        "flower_01", "flower_02", "flower_03",
        "flower_04", "flower_05", "flower_06"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                        ForEach(dataArray, id: \.self) { item in
                            NavigationLink(destination: DetailView(name: item)) {
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 180)
                                    .clipShape(.buttonBorder)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Main View")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ContentView()
}
