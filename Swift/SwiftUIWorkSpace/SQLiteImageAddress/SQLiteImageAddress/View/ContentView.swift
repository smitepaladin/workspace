//
//  ContentView.swift
//  RealmImageAddress
//
//  Created by Kenny Hahn on 8/8/25.
//

import SwiftUI


struct ContentView: View {
    @State var addressList: [Address] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(addressList, id: \.id, content: { address in
                    NavigationLink(destination: DetailView(addressList: address, image: address.image), label: {
                        HStack(content: {
                            Image(uiImage: address.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            VStack(content: {
                                Text(address.name)
                                    .font(.headline)
                                Text(address.phone)
                                    .font(.subheadline)
                            })
                        })
                    })
                })
            }
            .onAppear(perform: {
                addressList.removeAll()
                let addressDB = AddressDB()
                addressList = addressDB.queryDB()
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
