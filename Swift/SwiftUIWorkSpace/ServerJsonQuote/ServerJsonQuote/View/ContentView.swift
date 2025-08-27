//
//  ContentView.swift
//  ServerJsonQuote
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var quotes: [quoteJSON] = []
    
    var body: some View {
        NavigationView(content: {
            List(quotes, id:\.quote, rowContent: {quote in // List는 Foreach필요없다
                VStack(alignment: .leading, content: {
                    HStack{

                        VStack(alignment: .leading, content:{
                            Text("\(quote.quote)")
                                .font(.system(size: 18))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)

                            
                            Spacer()
                            
                            Text("\(quote.name)")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)

                        })
                        
                        Spacer()
                       


                    }
                    .padding()

                    })
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            })
            .navigationTitle("명언집")
        })
        .padding()
        .onAppear {
            let queryModel = QueryModel()
            Task {
                quotes = try await queryModel.loadData(url: URL(string: "https://zeushahn.github.io/Test/ios/quote.json")!)
            }
        }
    } // body
}// View

#Preview {
    ContentView()
}
