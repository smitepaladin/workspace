//
//  QueryModel.swift
//  FirebaseImageAddress
//
//  Created by Jun Jong Eck on 8/11/25.
//

import SwiftUI
import FirebaseFirestore

struct QueryModel {
    let db = Firestore.firestore()
    @Binding var addressList: [DBModel]

    func downloadItems() async {
        do {
            // Firestore에서 데이터를 비동기로 가져옴
            let querySnapshot = try await db.collection("addresslists")
                .order(by: "name")
                .getDocuments()
            
            print("Data is downloaded.")
            
            // 데이터 변환을 먼저 완료
            let locations = querySnapshot.documents.compactMap { document -> DBModel? in
                guard let data = document.data()["name"] else { return nil }
                print("\(document.documentID) => \(data)")
                
                return DBModel(
                    documentID: document.documentID,
                    name: document.data()["name"] as! String,
                    phone: document.data()["phone"] as! String,
                    address: document.data()["address"] as! String,
                    relation: document.data()["relation"] as! String,
                    imageAddress: document.data()["imageAddress"] as! String
                )
            }
            
            // UI 업데이트는 메인 스레드에서 안전하게 실행
            await MainActor.run {
                addressList = locations
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
}
