//
//  ContentView.swift
//  RealmImageAddress
//
//  Created by Kenny Hahn on 8/8/25.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
    @State var addressList: [AddressJSON] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(addressList, id: \.id, content: { address in
                    NavigationLink(destination: DetailView(addressList: address), label: {
                        HStack(content: {
                            WebImage(url: URL(string: "http://127.0.0.1:8000/view/\(address.image)"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(.buttonBorder)
                            
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
                Task{
                    addressList = try await loadData(url: URL(string: "http://127.0.0.1:8000/select")!)
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
    
    func loadData(url: URL) async throws -> [AddressJSON]{
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([AddressJSON].self, from: data)
    }
    
    
} // View

#Preview {
    ContentView()
}
