//
//  AddView.swift
//  RealmImageAddress(Nosql)
//
//  Created by 강인환 on 8/8/25.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    
    @State var name: String = ""
    @State var phone: String = ""
    @State var address: String = ""
    @State var relation: String = ""
    @State var image: UIImage?

    @FocusState var isFocused: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var isAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading ,content: {
            HStack(content: {
                Text("이름 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("이름 입력", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            HStack(content: {
                Text("전화번호 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("전화번호 입력", text: $phone)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("주소 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("주소 입력", text: $address)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            HStack(content: {
                Text("관계 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("관계 입력", text: $relation)
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
            
            PhotosPicker("Select an Image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                            
                           
                        }
                    }
                })
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFit()
                    .clipShape(Circle())
            }
            
            
            Spacer()
            
            HStack(content: {
                Button("등록", action: {
                    let addressDB = AddressDB()
                    let result = addressDB.insertDB(name: name, phone: phone, address: address, relation: relation, image: image!)
                    if result {
                        isAlert = true
                    }else{
                     print("Error")
                    }  
                })
                .padding()
                .frame(width: 80)
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                .alert("입력되었습니다.", isPresented: $isAlert,
                actions: {
                    Button("네, 알겠습니다.", action: {
                        dismiss()
                    })
                }
                )
            })
            Spacer()
        })
    } // body
} // view

