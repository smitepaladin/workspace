//
//  AddView.swift
//  RealmImageAddress
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @ObservedObject var realmManager: RealmManager // 실행되어있는 데이터베이스 연결
    @State var name: String = ""
    @State var phone: String = ""
    @State var address: String = ""
    @State var relation: String = ""
    @State var image: UIImage? // 보여줄 때 필요
    @State var imageData: Data? // 데이터값
    @FocusState var isFocused: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var isAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(content: {
                Text("이름 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("이름 입력", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("전화번호 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("전화번호 입력", text: $phone)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("주소 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("주소 입력", text: $address)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("관계 :")
                    .frame(minWidth: 70, alignment: .leading)// 최소너비와 왼쪽 정렬
                
                TextField("관계 입력", text: $relation)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
        })
        .padding()
        .navigationTitle("주소록 입력")
        .navigationBarTitleDisplayMode(.inline)
        
        // 버튼을 가운데 배치
        VStack(content: {
            Spacer()
            

            
            PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                            imageData = data
                        }
                    }
                })
            
            Spacer()
            
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
            }
            
            Spacer()
            
            HStack(content: {
                Button("등록", action:{
                    let newContact = Contact()
                    newContact.name = name
                    newContact.phone = phone
                    newContact.address = address
                    newContact.relation = relation
                    newContact.imageData = imageData
                    
                    realmManager.addContact(newContact)
                    isAlert = true
                })
                .padding()
                .frame(width: 80)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                .alert("입력 되었습니다.", isPresented: $isAlert, actions: {
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
    AddView(realmManager: RealmManager())
}
