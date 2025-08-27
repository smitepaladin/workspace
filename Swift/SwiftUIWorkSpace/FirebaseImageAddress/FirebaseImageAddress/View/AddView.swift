//
//  AddView.swift
//  RealmImageAddress(Nosql)
//
//  Created by 강인환 on 8/8/25.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

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
    @State var downURL: String = "" // Storage 주소 받아오는 변수
    @State var isLoading: Bool = false
    @State var errorMessage: String?
    
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
                        await loadImage()
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
                Spacer()
                Button("등록", action: registerAddress)
                    .padding()
                    .frame(width: 80)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(.buttonBorder)
                    .disabled(isLoading) // isLoading이 true일 때는 버튼이 먹히지 않는다.
                
                if isLoading {
                    ProgressView()
                }
                
                Spacer()
            })
            .alert("입력되었습니다.", isPresented: $isAlert,
                   actions: {
                Button("네, 알겠습니다.", action: {
                    dismiss()
                })
            })
            
            .alert(errorMessage ?? "오류가 발생했습니다.",isPresented: .constant(errorMessage != nil)){
                Button("확인"){
                    errorMessage = nil
                }
            }
            
            Spacer()
            
        }) // ***
    } // body
    
    // -- Functions --
    func loadImage() async{
        do{
            if let data = try await
                selectedItem?.loadTransferable(type: Data.self){
                await MainActor.run{
                    image = UIImage(data: data)
                }
            }
        }catch{
            print("Error loading image: \(error)")
            await MainActor.run{
                errorMessage = "이미지 로딩 중 오류가 발생했습니다."
            }
        }
    }
    
    
    func uploadImage() async throws -> String {
         guard let image = image else {
             throw NSError(domain: "ImageUpload", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지가 선택되지 않았습니다."])
         }
         
         let storageRef = Storage.storage().reference()
         guard let imageData = image.jpegData(compressionQuality: 0.4) else {
             throw NSError(domain: "ImageCompression", code: 0, userInfo: [NSLocalizedDescriptionKey: "이미지 압축에 실패했습니다."])
         }
         
         let imageRef = storageRef.child("images/\(name).jpg")
         let metadata = StorageMetadata()
         metadata.contentType = "image/jpg"
         
         let _ = try await imageRef.putDataAsync(imageData, metadata: metadata)
         let downloadURL = try await imageRef.downloadURL()
         
         return downloadURL.absoluteString
     } 
    
    
    func registerAddress() {
        Task {
            do {
                isLoading = true
                let imageUrl = try await uploadImage()
                let insertAddress = InsertModel()
                let result = insertAddress.insertItems(name: name, phone: phone, address: address, relation: relation, imageAddress: imageUrl)
                
                await MainActor.run {
                    isLoading = false
                    if result {
                        isAlert = true
                    } else {
                        errorMessage = "주소 등록 중 오류가 발생했습니다."
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

} // view

#Preview {
    AddView()
}
