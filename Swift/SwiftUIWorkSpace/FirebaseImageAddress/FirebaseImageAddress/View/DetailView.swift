import SwiftUI
import PhotosUI
import FirebaseStorage

struct DetailView: View {
    
    @State var addressList: DBModel
    @State var image: UIImage?
    @FocusState var isFocused: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var isUpdateAlert: Bool = false
    @State var isDeleteAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    @State var downURL: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("이름 :")
                    .frame(minWidth: 70, alignment: .leading)
                TextField("이름 수정", text: $addressList.name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            }
            
            HStack {
                Text("전화번호 :")
                    .frame(minWidth: 70, alignment: .leading)
                TextField("전화번호 수정", text: $addressList.phone)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            }
            
            HStack {
                Text("주소 :")
                    .frame(minWidth: 70, alignment: .leading)
                TextField("주소 수정", text: $addressList.address)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            }
            
            HStack {
                Text("관계 :")
                    .frame(minWidth: 70, alignment: .leading)
                TextField("관계 수정", text: $addressList.relation)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isFocused)
            }
        }
        .padding()
        .navigationTitle("주소록 수정")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            downURL = addressList.imageAddress
            displayImage()
        }
        
        VStack {
            Spacer()
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .clipShape(Circle())
            }
            
            Spacer()
            
            PhotosPicker("Select an Image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem) {
                    Task {
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                        }
                        await deleteImage(name: addressList.name)
                        await insertImage(name: addressList.name)
                    }
                }
            
            Spacer()
            
            HStack {
                Button("수정", action: updateAddress)
                    .padding()
                    .frame(width: 80)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(.buttonBorder)
                    .disabled(isLoading)
                
                Button("삭제", action: deleteAddress)
                    .padding()
                    .frame(width: 80)
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(.buttonBorder)
                    .disabled(isLoading)
                
                if isLoading {
                    ProgressView()
                }
            }
            .alert("수정되었습니다.", isPresented: $isUpdateAlert) {
                Button("네, 알겠습니다.") {
                    dismiss()
                }
            }
            .alert("삭제되었습니다.", isPresented: $isDeleteAlert) {
                Button("네, 알겠습니다.") {
                    dismiss()
                }
            }
            
            Spacer()
        }
    }
    
    // --- functions ---
    func displayImage() {
        let storage = Storage.storage()
        let httpsReference = storage.reference(forURL: addressList.imageAddress)
        
        httpsReference.getData(maxSize: Int64(1 * 1024 * 1024)) { data, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data {
                image = UIImage(data: data)
            }
        }
    }
    
    func deleteImage(name: String) async {
        let storage = Storage.storage()
        let httpsReference = storage.reference(forURL: addressList.imageAddress)
        
        do {
            try await httpsReference.delete()
            print("Successfully Deleted!")
        } catch {
            print("Error Delete: \(error)")
        }
    }
    
    func insertImage(name: String) async {
        let storageRef = Storage.storage().reference()
        
        guard let imageData = image?.jpegData(compressionQuality: 0.4) else { return }
        let imageRef = storageRef.child("images/\(name).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            guard metadata != nil else {
                print("Error : putfile")
                return
            }
            imageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error : DownloadURL")
                    return
                }
                downURL = "\(downloadURL)"
            }
        }
        print("--- Completed to insert a image ----")
    }
    
    func deleteAddress() {
        isLoading = true
        Task {
            do {
                await deleteImage(name: addressList.name)
                let deleteAddress = DeleteModel()
                let result = try await deleteAddress.deleteItems(documentID: addressList.documentID)
                
                await MainActor.run {
                    isLoading = false
                    if result {
                        isDeleteAlert = true
                    } else {
                        print("Error deleting address")
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
                print("Unexpected error: \(error)")
            }
        }
    }
    
    func uploadImage(image: UIImage, name: String) async throws -> String {
        let storageRef = Storage.storage().reference()
        
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            throw NSError(domain: "ImageCompression", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to compress image"])
        }
        
        let imageRef = storageRef.child("images/\(name).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let _ = try await imageRef.putDataAsync(imageData, metadata: metadata)
        let downloadURL = try await imageRef.downloadURL()
        
        return downloadURL.absoluteString
    }
    
    func updateAddress() {
        isLoading = true
        
        Task {
            do {
                // 이미지가 있는 경우 삭제 후 업로드
                if let image = image {
                    await deleteImage(name: addressList.name)
                    downURL = try await uploadImage(image: image, name: addressList.name)
                }
                
                // UpdateModel 사용
                let updateAddress = UpdateModel()
                let result = await updateAddress.updateItems(
                    documentID: addressList.documentID,
                    name: addressList.name,
                    phone: addressList.phone,
                    address: addressList.address,
                    relation: addressList.relation,
                    imageAddress: downURL
                )
                
                // UI 업데이트는 메인 액터에서 실행
                await MainActor.run {
                    isLoading = false
                    if result {
                        isUpdateAlert = true
                    } else {
                        print("Error updating address")
                    }
                }
            } catch {
                // 에러 처리
                await MainActor.run {
                    isLoading = false
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}

//
//#Preview {
//    DetailView()
//}
