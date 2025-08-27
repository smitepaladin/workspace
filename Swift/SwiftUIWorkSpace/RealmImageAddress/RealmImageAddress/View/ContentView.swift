//
//  ContentView.swift
//  RealmImageAddress
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(realmManager.contacts){contact in // 데이터베이스에서 직접들고온다.
                    NavigationLink(destination: DetailView(realmManager: realmManager, contact: contact, imageData: contact.imageData), label: {
                        HStack(content: {
                            if let imageData = contact.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }else{
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.gray)
                            }
                            
                            VStack(content: {
                                Text(contact.name)
                                    .font(.headline)
                                Text(contact.phone)
                                    .font(.subheadline)
                            })
                        })
                    })
                }
                .onDelete(perform: {indexSet in
                    deleteContent(at: indexSet)
                })
            }
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing, content:{
                 NavigationLink(destination: AddView(realmManager: realmManager),
                     label:{
                     Image(systemName: "plus.circle")
                     
                 })
                 
                })
            }
        }
    }//Body
    
    // -- functions ---
    
    func deleteContent(at offsets: IndexSet){
        for index in offsets{
            let contacts = realmManager.contacts[index]
            realmManager.deleteContact(contacts)
        }
    }
    
}//View

#Preview {
    ContentView()
}
