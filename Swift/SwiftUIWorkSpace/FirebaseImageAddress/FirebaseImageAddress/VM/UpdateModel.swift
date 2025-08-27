//
//  UpdateModel.swift
//  FirebaseImageAddress
//
//  Created by Jun Jong Eck on 8/11/25.
//

import Foundation
import Firebase


struct UpdateModel {
    let db = Firestore.firestore()
    
    func updateItems(documentID: String, name: String, phone: String, address: String, relation: String, imageAddress: String) async -> Bool {
        do {
            try await db.collection("addresslists").document(documentID).updateData([
                "name": name,
                "phone": phone,
                "address": address,
                "relation": relation,
                "imageAddress": imageAddress
            ])
            return true
        } catch {
            print("Error updating document: \(error)")
            return false
        }
    }
}
