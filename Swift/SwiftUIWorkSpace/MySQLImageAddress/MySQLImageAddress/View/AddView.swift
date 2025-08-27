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
    
    @State var filename: String = "" // PhotoPicker에서 선택파일 이름
    @State var imageData: Data? // PhotoPicker에서 선택된 이미지 , 메모리에 있다고 봐도 된다.
    
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
                            filename = selectedItem?.itemIdentifier ?? UUID().uuidString // UUID가  없다는것은 선택을 못했거나, 이미지가 아니라 다른것을 선택했거나.
                            imageData = data // 이미지선택은 끝났고, 데이터는 imageData로 옮겨놨다.
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
                    var urlPath = "http://127.0.0.1:8000/insert?name=\(name)&phone=\(phone)&address=\(address)&relation=\(relation)&image=\(filename)"
                    // 한글 url encoding
                    urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    
                    let url: URL = URL(string: urlPath)! // urlPath만이 아니라 url도 보내는 이유는 누가 보냈는지 알리기 위함이다. 답장을 받아야하니
                    
                    Task{
                        await uploadImage(imageData: imageData!) // 일단 서버에 이미지부터 올리겠다.
                        await insertAction(url: url) // 데이터베이스에 url을 insert한다.
                        // 이미지를 올리는것, insert시키는것 둘 다 되어야 에러가 안 나기 때문에 Task로 동시에 처리하기 위해서 묶은것이다.
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
    
    //  --- Fucntions ---
    func uploadImage(imageData: Data) async{
        guard let url = URL(string: "http://127.0.0.1:8000/upload") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // POST방식 체크, 이미지데이터를 나눠서 보낼 수 있다.
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        // 멀티파트로 쓰겠다. 바운더리는 알아서
        var body = Data()
        
        // Add the image data to the raw http request data 이미지를 자를 때 키값을 달아주는 것이다.
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!) // 타입은 뭐다
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        do { // 네트워크로 날아가는 부분
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200, // 잘 되었다.
               let result = String(data: data, encoding: .utf8) {
                print("Upload successful. Server response: \(result)")
            } else {
                print("Upload failed")
            }
        } catch {
            print("Error uploading image: \(error.localizedDescription)")
        }
    }
    
    func insertAction(url: URL) async{
        do{
            let(_, _) = try await URLSession.shared.data(from: url)
            isAlert = true
            
        }catch{
            print("Failed to insert data")
            isAlert = false
        }
    }
    
    
} // view

#Preview {
    AddView()
}
