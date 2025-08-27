//
//  DetailView.swift
//  RealmImageAddress(Nosql)
//
//  Created by 강인환 on 8/8/25.
//

import SwiftUI
import PhotosUI

struct DetailView: View {
    
    @State var addressList: Address
    @State var image: UIImage?
    @FocusState var isFocused: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var isUpdateAlert: Bool = false
    @State var isDeleteAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading ,content: {
            HStack(content: {
                Text("이름 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("이름 수정", text: $addressList.name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            HStack(content: {
                Text("전화번호 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("전화번호 수정", text: $addressList.phone)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            
            HStack(content: {
                Text("주소 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("주소 수정", text: $addressList.address)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            })
            HStack(content: {
                Text("관계 :")
                    .frame(minWidth: 70, alignment: .leading) // 최소 너비와 왼쪽 정렬
                
                TextField("관계 수정", text: $addressList.relation)
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
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit( )
                    .clipShape(Circle())
            }
            
            Spacer()
            
            PhotosPicker("Select an Image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)!
                        }
                    }
                })
            Spacer()
            
            HStack(content: {
                Button("수정", action: {
                    let addressDB = AddressDB()
                    let result = addressDB.updateDB(id: addressList.id, name: addressList.name, phone: addressList.phone, address: addressList.address, relation: addressList.relation, image: image!)
                    
                    if result {
                        isUpdateAlert = true
                    } else {
                        print("DB 수정 실패")
                    }

                })
                .padding()
                .frame(width: 80)
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                .alert("수정되었습니다.", isPresented: $isUpdateAlert,
                actions: {
                    Button("네, 알겠습니다.", action: {
                        dismiss()
                    })
                }
                )
                Button("삭제", action: {
                    let addressDB = AddressDB()
                    let result = addressDB.deleteDB(id: addressList.id)
                    
                    if result {
                        isDeleteAlert = true
                    } else {
                        print("DB 삭제 실패")
                    }

                })
                .padding()
                .frame(width: 80)
                .background(Color.red)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                .alert("삭제되었습니다.", isPresented: $isDeleteAlert,
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


