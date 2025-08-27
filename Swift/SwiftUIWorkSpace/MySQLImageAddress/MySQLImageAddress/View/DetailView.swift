//
//  DetailView.swift
//  RealmImageAddress(Nosql)
//
//  Created by 강인환 on 8/8/25.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI // ***** 추가되었음

struct DetailView: View {
    
    @State var addressList: AddressJSON
    @State var image: UIImage?
    @FocusState var isFocused: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var isUpdateAlert: Bool = false
    @State var isDeleteAlert: Bool = false
    
    @State var initImage: Bool = true // 이미지 바꿨는지 안바꿨는지 선택여부
    @State var imageData: Data? // PhotoPicker로 선택된 이미지
    @State var filename: String = "" // PhotoPicker로 선택된 이미지 파일 이름
    
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
            
            if initImage{
                WebImage(url: URL(string: "http://127.0.0.1:8000/view/\(addressList.image)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(.buttonBorder)
            }else{
                if let image{
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit( )
                        .clipShape(Circle())
                }
            }
            

            
            Spacer()
            
            PhotosPicker("Select an Image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    initImage = false
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                            filename = selectedItem?.itemIdentifier ?? UUID().uuidString
                            imageData = data
                        }
                    }
                })
            Spacer()
            
            HStack(content: {
                 Button("수정", action: {
                     if initImage {
                         var urlPath = "http://127.0.0.1:8000/update?name=\(addressList.name)&phone=\(addressList.phone)&address=\(addressList.address)&relation=\(addressList.relation)&id=\(addressList.id)"
                         // 한글 url encoding
                         urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                         
                         let url: URL = URL(string: urlPath)!
                         
                         Task {
                             await updateAction(url: url)
                         }
                         isFocused = false
                     } else {
                         var urlPath = "http://127.0.0.1:8000/updateAll?name=\(addressList.name)&phone=\(addressList.phone)&address=\(addressList.address)&relation=\(addressList.relation)&image=\(filename)&id=\(addressList.id)"
                         urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                         
                         let url: URL = URL(string: urlPath)!
                         
                         // 기존 파일 삭제
                         let urlPathDeleteFile = "http://127.0.0.1:8000/deleteFile/\(addressList.image)"
                         let urlFile = URL(string: urlPathDeleteFile)!
                         
                         Task {
                             await deleteFileAction(url: urlFile)
                             await uploadImage(imageData: imageData!)
                             await updateAction(url: url)
                         }
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
                    let urlPath = "http://127.0.0.1:8000/delete?id=\(addressList.id)"
                    let url: URL = URL(string: urlPath)!
                    
                    let urlDeletePath = "http://127.0.0.1:8000/deleteFile/\(addressList.image)"
                    let urlFile: URL = URL(string: urlDeletePath)!
                    
                    Task{
                        await deleteFileAction(url: urlFile)
                        await deleteAction(url: url)
                    }
                    isFocused = false
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
                })
            })
            Spacer()
        })
    } // body
               
    // --- Functions ---
    func updateAction(url: URL) async {
        do{
            let(_, _) = try await URLSession.shared.data(from: url)
            isUpdateAlert = true
        }catch{
            print("Failed to insert data")
            isUpdateAlert = false
        }
    }
    func deleteAction(url: URL) async {
        do{
            let(_, _) = try await URLSession.shared.data(from: url)
            isDeleteAlert = true
        }catch{
            print("Failed to insert data")
            isDeleteAlert = false
        }
    }
    func deleteFileAction(url: URL) async {
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let (_,_) = try await URLSession.shared.data(for: request)
        }catch{
            print("Failed to insert data")
        }
    }
    
    func uploadImage(imageData: Data) async {
        // 업로드할 서버 URL 생성 (여기서는 로컬호스트의 FastAPI 엔드포인트)
        guard let url = URL(string: "http://127.0.0.1:8000/upload") else {
            print("Invalid URL") // URL이 잘못되었을 때 경고 출력
            return
        }
        
        // URLRequest 생성 및 HTTP 메서드 설정 (POST 요청)
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Get을 POST로 바꿔줌,
        
        // multipart/form-data 전송을 위한 boundary 문자열 (데이터 구분선 역할)
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // HTTP Body에 담을 데이터 객체 생성
        var body = Data()
        
        // Add the image data to the raw http request data
        // ➡ 실제 업로드할 데이터의 시작 부분 (boundary로 구분)
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
        // form-data 필드 설정: name=서버가 받을 필드명, filename=업로드 파일명
        // filename 변수는 외부에서 설정되어 있어야 함
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        
        // 파일 타입 지정 (여기서는 JPEG 이미지)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        
        // 실제 이미지 데이터 추가
        body.append(imageData)
        
        // multipart 데이터의 마지막 boundary 표시
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // HTTP 요청 본문(body)에 데이터 첨부
        request.httpBody = body
        
        do {
            // async/await 방식으로 URLSession 호출
            // (서버 응답까지 기다렸다가 data와 response를 반환)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // HTTP 응답 코드가 200이면 성공 처리
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let result = String(data: data, encoding: .utf8) {
                print("Upload successful. Server response: \(result)") // 서버에서 온 메시지 출력
            } else {
                print("Upload failed") // 상태 코드가 200이 아니면 실패 처리
            }
        } catch {
            // 네트워크 요청 중 에러 발생 시 처리
            print("Error uploading image: \(error.localizedDescription)")
        }
    }
    
    
} // view


#Preview {
    DetailView(addressList: AddressJSON(id: 1, name: "John", phone: "1234", address: "Seoul", relation: "me", image: ""))
}
