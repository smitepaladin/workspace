//
//  ContentView.swift
//  RealmImageAddress
//
//  Created by Kenny Hahn on 8/8/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var addressList: [DBModel] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(addressList, id: \.documentID, content: { address in
                    NavigationLink(destination: DetailView(addressList: address), label: {
                        HStack(content: {
                            WebImage(url: URL(string: address.imageAddress))
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            VStack(content: {
                                Text("성명 : \(address.name)")
                                    .font(.headline)
                                Text("전화번호 : \(address.phone)")
                                    .font(.subheadline)
                            })
                        })
                    })
                })
            }
            .onAppear(perform: {
                addressList.removeAll()
                let addressQuery = QueryModel(addressList: $addressList)
                Task{
                    await addressQuery.downloadItems()
                }
            })
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing, content: {
                    NavigationLink(destination: AddView(), label: {
                        Image(systemName: "plus.circle")
                    })
                })
            }
        }
    } // body
    
    // --- Functions ---
    
    
    
} // View

#Preview {
    ContentView()
}
