//
//  ContentView.swift
//  ServerJsonCollectionList
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var movies: [MovieJSON] = []
    
    var body: some View {
        NavigationView(content: {
            ScrollView(content: {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10, content: {
                    ForEach(movies, id: \.self, content: {movie in
                        NavigationLink(destination: DetailView(movie: movie), label: {
                            VStack{
                                WebImage(url: movie.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 180)
                                    .clipShape(.buttonBorder)
                            }
                        })
                    })
                })
            })
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
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
