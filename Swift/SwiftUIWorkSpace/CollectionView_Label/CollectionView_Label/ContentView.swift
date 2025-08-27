//
//  ContentView.swift
//  CollectionView_Label
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var dataArray: [String] = [
        "유비","관우","장비","조조","여포","동탁","초선","손견"
    ]
    var body: some View {
        NavigationView(content: {
            VStack {
                    
                    ScrollView(.vertical,content: {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
                            ForEach(dataArray, id: \.self,content: {item in
                                NavigationLink(destination: DetailView(name: item), label: {
                                    Text(item)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                        .background(.blue)
                                        .foregroundStyle(.white)
                                        .clipShape(.buttonBorder)
                                })
                            })
                        })
                    })
                        .padding()
                    
                ScrollView(.horizontal,content: {
                    LazyHGrid(rows:[GridItem(.adaptive(minimum: 100))],spacing:10, content: {
                        HStack {
                            ForEach(dataArray, id: \.self, content: {item in
                                NavigationLink(destination: DetailView(name: item), label:{
                                    Text(item)
                                        .frame(minWidth: 100, maxWidth: 100,minHeight:100, maxHeight: 100)
                                        .background(.green)
                                        .foregroundStyle(.white)
                                        .clipShape(.buttonBorder)
                                    
                                })
                            })
                        }
                    })})
                    .padding()
                
                .navigationTitle("삼국지 인물")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        NavigationLink(destination: AddView(dataArray: $dataArray), label: {
                            Image(systemName: "plus.circle")
                        })
                    })
                })
            }
        })
    } // body
}// View

#Preview {
    ContentView()
}
