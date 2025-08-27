//
//  DetailView.swift
//  RealmImageAddress
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI
import PhotosUI
import RealmSwift

struct DetailView: View {
    @ObservedObject var realmManager: RealmManager // 실행되어있는 데이터베이스 연결
    @State var contact: Contact
    @State var imageData: Data?
    @FocusState var isFocused: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var isUpdateAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(content: {
                Text("이름 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("이름 수정", text: $contact.name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("전화번호 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("전화번호 수정", text: $contact.phone)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("주소 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("주소 수정", text: $contact.address)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("관계 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("관계 수정", text: $contact.relation)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
        })
        .padding()
        .navigationTitle("주소록 수정")
        .navigationBarTitleDisplayMode(.inline)
        
        // 버튼을 가운데 배치
        VStack(content: {
            Spacer()
            
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }else{
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            imageData = data
                        }
                    }
                })
            
            Spacer()
            
            HStack(content: {
                Button("수정", action:{
                    let newContact = Contact()
                    newContact.name = contact.name
                    newContact.phone = contact.phone
                    newContact.address = contact.address
                    newContact.relation = contact.relation
                    newContact.imageData = imageData
                    
                    realmManager.updateContact(contact, with: newContact)
                    isUpdateAlert = true
                })
                .padding()
                .frame(width: 80)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                .alert("수정 되었습니다.", isPresented: $isUpdateAlert, actions: {
                    Button("네, 알겠습니다.", action: {
                        dismiss()
                    })
                })
            })
            
            Spacer()
            
        })
    }//Body
}//View

#Preview {
    let tempRealmManager = RealmManager()
    let tempContact = Contact()
    tempContact.name = "John Doe"
    tempContact.phone = "123"
    tempContact.address = "Seoul"
    tempContact.relation = "me"
    tempContact.imageData = UIImage(named: "sampleImage")?.jpegData(compressionQuality: 0.8)
    return DetailView(realmManager: tempRealmManager, contact: tempContact)
}
