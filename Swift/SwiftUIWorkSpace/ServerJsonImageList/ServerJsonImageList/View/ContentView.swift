//
//  ContentView.swift
//  ServerJsonImageList
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var movies: [MovieJSON] = []
    
    var body: some View {
        NavigationView(content: {
            List(Array(movies.enumerated()), id: \.1.title) { index, movie in
                VStack(alignment: .leading) {
                    HStack(spacing: 30) {
                        WebImage(url: movie.image)
                            .resizable()
                            .frame(width: 100, height: 150)
                            .clipShape(.rect)
                            .shadow(radius: 10)
                        
                        Text(movie.title)
                            .font(.system(size: 18))
                            .bold()
                    }
                }
                .listRowBackground(index % 2 == 0 ? Color.white : Color.gray.opacity(0.1))
            }
            .navigationTitle("영화 리스트")
        })
        .padding()
        .onAppear {
            let queryModel = QueryModel()
            Task {
                movies = try await queryModel.loadData(url: URL(string: "https://zeushahn.github.io/Test/ios/movies.json")!)
            }
        }
    } // body
}// View

#Preview {
    ContentView()
}
