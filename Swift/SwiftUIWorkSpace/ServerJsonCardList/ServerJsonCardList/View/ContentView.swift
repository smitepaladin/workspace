//
//  ContentView.swift
//  ServerJsonCardList
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var newses: [newsJSON] = []
    
    var body: some View {
        NavigationView(content: {
            List(Array(newses), id: \.image) { news in
                VStack(alignment: .leading) {
                    
                    
                    WebImage(url: news.image)
                        .resizable()
                        .frame(width: 250, height: 160)
                        .shadow(radius: 10)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    

                    
                    Text(news.category)
                        .foregroundStyle(.gray)
                    
                    Text(news.heading)
                        .font(.system(size: 40, weight: .bold))
                        .lineLimit(3) // 최대 3줄
                        .truncationMode(.tail) // 뒤에 ... 붙임

                    
                    Text("WRITTEN BY \(news.author)")
                        .foregroundStyle(.gray)
                }
                .background(Color.white)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)        // ⬅ 모서리 둥글기
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2) // 테두리 색/두께
                )
                
            }
            .navigationTitle("News")
        })
        .padding(20)
        .onAppear {
            let queryModel = QueryModel()
            Task {
                newses = try await queryModel.loadData(url: URL(string: "https://zeushahn.github.io/Test/ios/cards.json")!)
            }
        }
    } // body
}// View

#Preview {
    ContentView()
}
